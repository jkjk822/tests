require 'minitest/autorun'

# This is a test file for fengEnum.rb. It requires minitest installed.
# The general test case using 4 different triples:
#     nil_triple = Triple.new
#     int_triple = Triple.new(1, 2, 3)
#     str_triple = Triple.new("string", "anotherString", "lastString")
#     mix_triple = Triple.new(1, 2.5, "str")
#
# For every test, the test case is general start by creating a
# nil triple and non-nil triple, and first it will test the safety
# issue. For example, incompatible argments, noMethodError, etc.
# Then, each test will test the nil case, followed by some genral 
# cases. Last, it will test the outOfBoudaryCondition.
# To run this script, type "ruby fengEnumtest.rb".

class FengEnumTests < Minitest::Test
    def test_all_for_initialize_triples
        int_triple = Triple.new(1, 2, 3)
        str_triple = Triple.new("string", "anotherString", "lastString")

        assert_equal int_triple.all? { |item| item > 1}, false
        assert_equal int_triple.all? { |item| item < 4}, true

        assert_equal str_triple.all? { |item| item.length >= 6}, true
        assert_equal str_triple.all? { |item| item.length > 7}, false

        assert_equal str_triple.all? { |item| item.include? "string" }, false
        assert_equal str_triple.all? { |item| item.downcase.include? "string"}, true
    end

    def test_any_for_initialize_triples
        int_triple = Triple.new(1, 2, 3)
        str_triple = Triple.new("string", "anotherString", "lastString")
    
        assert_equal int_triple.any? { |item| item > 1}, true
        assert_equal int_triple.all? { |item| item > 3}, false

        assert_equal str_triple.any? { |item| item.length > 6}, true
        assert_equal str_triple.any? { |item| item.length > "anotherString".length}, false

        assert_equal str_triple.any? { |item| item.include? "string" }, true
        assert_equal str_triple.any? { |item| item.downcase.include? "no_String"}, false
    end

    def test_chunk
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        str_triple = Triple.new("string", "anotherString", "lastString")
        mix_triple = Triple.new(1, 2.5, "str")

        nil_triple.chunk { |n| n == nil
            }.each{ |item, ary|
            assert ary.length == 3
            assert item == true
        }

        int_triple.chunk { |n| n >= 2
            }.each{ |result, ary| 
            if result == true then
                assert ary.length == 2
                assert_equal ary, [2,3] 
            else
                assert ary.length == 1
                assert_equal ary, [1]
            end      
        }

        assert_equal str_triple.chunk { |str| str.include? "string"}.to_a,
        [[true, ["string"]], [false, ["anotherString", "lastString"]]]

        mix_triple.chunk { |str| str.class
            }.each{ |result, ary| 
            if result == Integer then assert ary == [1]
            elsif result == Float then assert ary == [2.5]
            else assert ary == ["str"] 
            end  
        }
    end

    def test_chunk_while
        int_triple = Triple.new(1, 2, 3)
        mix_triple = Triple.new(1, 2.5, "str")

        assert_equal int_triple.chunk_while {|i,j| i.class == j.class}.to_a,
                                        [[1,2,3]]
        assert_equal int_triple.chunk_while {|i,j| i < j}.to_a,[[1,2,3]]
        assert_equal int_triple.chunk_while {|i,j| i > j}.to_a ,[[1],[2],[3]]
        assert_equal mix_triple.chunk_while {|i,j| i.class == j.class}.to_a,
                                        [[1],[2.5],["str"]]

    end

    def test_collect
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        str_triple = Triple.new("string", "anotherString", "lastString")

        assert_equal nil_triple.collect{|i| true if i == nil}.to_a,[true,true,true]

        assert_equal int_triple.collect{|i| i.to_s}.to_a,["1","2","3"]
        assert_equal str_triple.collect{|i| i.length}.to_a,[6,13,10]

    end

    def test_collect_concat
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        str_triple = Triple.new("string")

        assert_empty nil_triple.collect_concat {|i| [] if i == nil}.to_a
        assert int_triple.collect_concat {|i| [i, i]}.length == 6
        assert_equal str_triple.collect_concat {|i| i.class == String}, 
                            [true, false, false] 

    end

    def test_count
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        str_triple = Triple.new("string")

        assert_equal nil_triple.count,3
        assert_equal int_triple.count(nil),0
        assert_equal str_triple.count(nil),2
        assert_equal int_triple.count{|x| x > 2},1
        assert_equal str_triple.count("string"),1
        assert_equal str_triple.count(nil),2

    end

    def test_cycle
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)

        # refute_equal nil_triple.cycle(nil), nil 
        assert_nil int_triple.cycle(1){|i| i+1}
        assert_equal int_triple.cycle(2).to_a, [1,2,3,1,2,3]

    end

    def test_detect
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        
        assert_nil nil_triple.detect{|i| i != nil}
        assert_equal int_triple.detect{|i| i > 1}, 2
        assert_nil int_triple.detect{|i| i > 3}
    end

    def test_drop
        int_triple = Triple.new(1, 2, 3)
        
        assert_equal int_triple.drop(0),[1,2,3]
        assert_equal int_triple.drop(2),[3]
        assert_empty int_triple.drop(4)

    end

    def test_drop_while
        nil_triple = Triple.new
        int_triple = Triple.new(1,2,3)
        
        # assert_equal nil_triple.drop_while.to_a,[nil]
        assert_equal nil_triple.drop_while {|i| i == nil},[]
        assert_equal nil_triple.drop_while {|i| i != nil},[nil,nil,nil]

        assert_empty int_triple.drop_while{|i| i > 0}
        assert_equal int_triple.drop_while{|i| i == 1},[2,3]
        assert_equal int_triple.drop_while{|i| i > 3},[1,2,3]
        # assert_equal int_triple.drop_while.to_a,[1]
    end

    def test_each_cons
        int_triple = Triple.new(1,2,3)

        assert_nil int_triple.each_cons(2){|i| i}
        assert_nil int_triple.each_cons(4){|i| i}
    end

    def test_each_entry
        nil_triple = Triple.new
        int_triple = Triple.new(1,2,3)

        assert_equal nil_triple.each_entry{|i| i},nil_triple

        nil_triple.each_entry{ |i| assert_nil i }
        int_triple.each_entry{ |i| assert (i < 4),true }
    end

    def test_each_with_index
        nil_triple = Triple.new
        int_triple = Triple.new(1,2,3)

        assert_equal nil_triple.each_with_index{|item, index| assert_nil item },nil_triple
        assert_equal int_triple.each_with_index{|item, index| assert index < 3 },int_triple
        assert_equal int_triple.each_with_index{|item, index| assert_equal index+1,item },
                                int_triple
        assert_equal int_triple.each_with_index.to_a, [[1, 0], [2, 1], [3, 2]]
    end

    def test_each_with_object
        nil_triple = Triple.new
        int_triple = Triple.new(1,2,3)

        nil_triple.each_with_object(nil){|i, obj| assert_nil i }
        assert_equal int_triple.each_with_object(["1",2.5]){|i, obj| obj << i },
                                ["1",2.5, 1, 2, 3]
        
    end

    def test_entries
        nil_triple = Triple.new
        int_triple = Triple.new(1,2,3)

        refute_equal nil_triple.entries,nil
        assert_equal nil_triple.entries,nil_triple.to_a

        refute_equal int_triple.entries,int_triple
        refute_equal int_triple.entries,[1,2]
        assert_equal int_triple.entries,int_triple.to_a
    end

    def test_find
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        
        assert_nil nil_triple.find{|i| i != nil}

        assert_equal int_triple.find{|i| i > 1}, 2
        assert_nil int_triple.find{|i| i > 3}
    end

    def test_find_all
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        
        assert_empty nil_triple.find_all{|i| i != nil}

        assert_equal int_triple.find_all{|i| i > 1}, [2,3]
        assert_empty int_triple.find_all{|i| i > 3}
    end

    def test_find_index
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)

        assert_equal nil_triple.find_index(nil),0
        assert_nil nil_triple.find_index{|i| i != nil}

        assert_equal int_triple.find_index{|i| i > 1},1
        assert_nil int_triple.find_index{|i| i > 3}
    end

    def test_first
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)

        assert_nil nil_triple.first
        assert_nil [].first
        assert_equal int_triple.first,1
        assert_equal int_triple.first(1),[1]

        assert_empty int_triple.first(0)
        assert_equal int_triple.first(4),[1,2,3]
    end

    def test_flat_map
        nil_triple = Triple.new
        tri_nil_triple = Triple.new(nil_triple.to_a, nil_triple.to_a, nil_triple.to_a)

        assert_equal tri_nil_triple.flat_map{|i| i}.to_a,Array.new(9,nil)
        assert_equal tri_nil_triple.flat_map{|i| i << 1}.to_a,
            [nil, nil, nil, 1, nil, nil, nil, 1, nil, nil, nil, 1]
    end

    def test_grep
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        str_triple = Triple.new("string", "anotherString", "lastString")

        assert_empty nil_triple.grep(/What?/)

        assert_empty int_triple.grep(/1/)
        assert_equal int_triple.grep(1),[1]
        assert_equal int_triple.grep(1..3),[1,2,3]

        assert_empty int_triple.grep(/1/){|i| i.to_s}
        assert_equal int_triple.grep(1){|i| i.to_s},["1"]
        assert_equal int_triple.grep(1..3){|i| i.to_s},["1","2","3"]

        assert_empty str_triple.grep(/^A-Za-z/)
        assert_equal str_triple.grep(/String/),["anotherString", "lastString"]
        assert_equal str_triple.grep(/String/){|i| i.length},[13, 10]
    end

    def test_grep_v
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        str_triple = Triple.new("string", "anotherString", "lastString")

        refute_empty nil_triple.grep_v(/What?/)

        assert_equal int_triple.grep_v(/1/),int_triple.to_a
        assert_equal int_triple.grep_v(1),[2,3]
        assert_empty int_triple.grep_v(1..3)

        assert_equal int_triple.grep_v(/1/){|i| i.to_s},["1","2","3"]
        assert_equal int_triple.grep_v(1){|i| i.to_s},["2","3"]
        assert_empty int_triple.grep_v(1..3){|i| i.to_s}

        assert_equal str_triple.grep_v(/^A-Za-z/),str_triple.to_a
        assert_equal str_triple.grep_v(/String/),["string"]
        assert_equal str_triple.grep_v(/String/){|i| i.length},[6]
    end

    def test_group_by
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        mix_triple = Triple.new(1, 2.5, "str")

        assert_equal nil_triple.group_by{|i| i.class},{NilClass=>[nil, nil, nil]}
        assert_equal int_triple.group_by{|i| i%1},{0=>[1, 2, 3]}
        assert_equal int_triple.group_by{|i| i%3},{0=>[3], 1=>[1], 2=>[2]}
        assert_equal mix_triple.group_by{|i| i.class},
                    {Integer=>[1], Float=>[2.5], String=>["str"]}
    end

    def test_include?
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        mix_triple = Triple.new(1, 2.5, "str")

        assert_equal (nil_triple.include? nil), true

        assert_equal (int_triple.include? nil), false
        assert_equal (int_triple.include? 4),false

        assert_equal (mix_triple.include? 1), true
        assert_equal (mix_triple.include? 2.5), true 
        assert_equal (mix_triple.include? "str"), true
    end

    def test_inject
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        str_triple = Triple.new("string", "anotherString", "lastString")

        assert_equal int_triple.inject(:+),6
        assert_equal str_triple.inject(:+),"stringanotherStringlastString"

        assert_equal int_triple.inject(:*),6
        assert_equal str_triple.inject(:<<),"stringanotherStringlastString"

        str_triple = Triple.new("string", "anotherString", "lastString")

        assert_equal int_triple.inject(2,:+),8
        assert_equal int_triple.inject(2,:*),12
        assert_equal str_triple.inject("What??",:+),
            "What??stringanotherStringlastString"

        assert_equal int_triple.inject {|memo,obj| memo + obj}, 6
        assert_equal str_triple.inject {|memo,obj| memo + obj},
                                    "stringanotherStringlastString"
        assert_equal int_triple.inject(2) {|memo,obj| memo + obj}, 8
        assert_equal str_triple.inject("What??") {|memo,obj| memo + obj},
                                    "What??stringanotherStringlastString"

    end

    def test_map
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        str_triple = Triple.new("string", "anotherString", "lastString")

        assert_equal nil_triple.map{|i| true if i == nil}.to_a,[true,true,true]

        assert_equal int_triple.map{|i| i.to_s}.to_a,["1","2","3"]
        assert_equal str_triple.map{|i| i.length}.to_a,[6,13,10]
    end

    def test_max
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        str_triple = Triple.new("string", "anotherString", "lastString")
        mix_triple = Triple.new(1, 2.5, "str")

        assert_nil nil_triple.max
        assert_equal int_triple.max,3
        assert_equal str_triple.max,"string"

        assert_equal int_triple.max{|a,b| -a <=> -b },1
        assert_equal str_triple.max{|a,b| a.length <=> b.length},
                                "anotherString"

        assert_equal nil_triple.max(2),[nil,nil]
        assert_equal int_triple.max(2),[3,2]
        assert_equal str_triple.max(2),["string", "lastString"]

        assert_equal int_triple.max(2) {|a,b| -a <=> -b },[1,2]
        assert_equal str_triple.max(2){|a,b| a.length <=> b.length},
                                ["anotherString", "lastString"]

        assert_empty nil_triple.max(0)
        assert_empty int_triple.max(0)
        assert_empty str_triple.max(0)
        assert_empty mix_triple.max(0)

        assert_equal nil_triple.max(4),[nil,nil,nil]
        assert_equal int_triple.max(4),[3,2,1]
        assert_equal str_triple.max(4),["string", "lastString","anotherString"]

        assert_equal int_triple.max(4) {|a,b| -a <=> -b },[1,2,3]
        assert_equal str_triple.max(4){|a,b| a.length <=> b.length},
                                ["anotherString", "lastString","string"]
    end

    def test_max_by
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        str_triple = Triple.new("string", "anotherString", "lastString")
        mix_triple = Triple.new(1, 2.5, "str")

        assert_equal int_triple.max_by{|a| -a },1
        assert_equal str_triple.max_by{|a| a.length},
                                "anotherString"

        assert_equal int_triple.max_by(2) {|a| -a},[1,2]
        assert_equal str_triple.max_by(2){|a| a.length},
                                ["anotherString", "lastString"]

        assert_empty nil_triple.max_by(0){}
        assert_empty int_triple.max_by(0){}
        assert_empty str_triple.max_by(0){}
        assert_empty mix_triple.max_by(0){}

        assert_equal nil_triple.max_by(4).to_a,[nil,nil,nil]
        assert_equal int_triple.max_by(4).to_a,[1,2,3]
        assert_equal str_triple.max_by(4).to_a,
                                ["string", "anotherString", "lastString"]

        assert_equal int_triple.max_by(4) {|a| -a},[1,2,3]
        assert_equal str_triple.max_by(4){|a| a.length},
                                ["anotherString", "lastString","string"]
    end

    def test_member?
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        mix_triple = Triple.new(1, 2.5, "str")

        assert_equal (nil_triple.member? nil), true

        assert_equal (int_triple.member? nil), false
        assert_equal (int_triple.member? 4),false

        assert_equal (mix_triple.member? 1), true
        assert_equal (mix_triple.member? 2.5), true 
        assert_equal (mix_triple.member? "str"), true
    end

    def test_min
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        str_triple = Triple.new("string", "anotherString", "lastString")
        mix_triple = Triple.new(1, 2.5, "str")

        assert_nil nil_triple.min
        assert_equal int_triple.min,1
        assert_equal str_triple.min,"anotherString"

        assert_equal int_triple.min{|a,b| -a <=> -b },3
        assert_equal str_triple.min{|a,b| a.length <=> b.length},
                                "string"

        assert_equal nil_triple.min(2),[nil,nil]
        assert_equal int_triple.min(2),[1,2]
        assert_equal str_triple.min(2),["anotherString", "lastString"]

        assert_equal int_triple.min(2) {|a,b| -a <=> -b },[3,2]
        assert_equal str_triple.min(2){|a,b| a.length <=> b.length},
                                ["string", "lastString"]

        assert_empty nil_triple.min(0)
        assert_empty int_triple.min(0)
        assert_empty str_triple.min(0)
        assert_empty mix_triple.min(0)

        assert_equal nil_triple.min(4),[nil,nil,nil]
        assert_equal int_triple.min(4),[1, 2, 3]
        assert_equal str_triple.min(4),["anotherString", "lastString", "string"]

        assert_equal int_triple.min(4) {|a,b| -a <=> -b },[3, 2, 1]
        assert_equal str_triple.min(4){|a,b| a.length <=> b.length},
                                ["string", "lastString", "anotherString"]
    end

    def test_min_by
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        str_triple = Triple.new("string", "anotherString", "lastString")
        mix_triple = Triple.new(1, 2.5, "str")

        assert_equal int_triple.min_by{|a| -a }, 3
        assert_equal str_triple.min_by{|a| a.length},
                                "string"

        assert_equal int_triple.min_by(2) {|a| -a},[3,2]
        assert_equal str_triple.min_by(2){|a| a.length},
                                ["string", "lastString"]

        assert_empty nil_triple.min_by(0){}
        assert_empty int_triple.min_by(0){}
        assert_empty str_triple.min_by(0){}
        assert_empty mix_triple.min_by(0){}

        assert_equal nil_triple.min_by(4).to_a,[nil,nil,nil]
        assert_equal int_triple.min_by(4).to_a,[1,2,3]
        assert_equal str_triple.min_by(4).to_a,
                                ["string", "anotherString", "lastString"]

        assert_equal int_triple.min_by(4) {|a| -a},[3,2,1]
        assert_equal str_triple.min_by(4){|a| a.length},
                                ["string", "lastString","anotherString"]
    end

    def test_minmax
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        str_triple = Triple.new("string", "anotherString", "lastString")
        mix_triple = Triple.new(1, 2.5, "str")

        assert_equal nil_triple.minmax,[nil,nil]
        assert_equal int_triple.minmax,[1,3]
        assert_equal str_triple.minmax, ["anotherString", "string"]

        assert_equal int_triple.minmax{|a,b| -a <=> -b },[3,1]
        assert_equal str_triple.minmax{|a,b| a.length <=> b.length},
                                ["string", "anotherString"]

    end

    def test_minmax_by
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        str_triple = Triple.new("string", "anotherString", "lastString")
        mix_triple = Triple.new(1, 2.5, "str")

        assert_equal int_triple.minmax_by{|a| -a },[3,1]
        assert_equal str_triple.minmax_by{|a| a.length},
                                ["string", "anotherString"]               
    end

    def test_none?
        nil_triple = Triple.new
        true_triple = Triple.new(true,true,true)
        false_triple = Triple.new(false,false,false)

        assert_equal true_triple.none?{|b| false},true
        assert_equal false_triple.none?{|b| 1},false       
    end

    def test_one?
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        true_triple = Triple.new(true,true,true)
        one_triple = Triple.new(true,false)

        assert_equal int_triple.one?{|b| b == 2},true
        assert_equal true_triple.one?{|b| b == 2},false         
    end

    def test_partition
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)

        assert_equal nil_triple.partition{|i| i == nil},[[nil,nil,nil],[]]
        assert_equal int_triple.partition{|i| i > 1},[[2,3],[1]]
              
    end

    def test_reduce
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        str_triple = Triple.new("string", "anotherString", "lastString")

        assert_equal int_triple.reduce(:+),6
        assert_equal str_triple.reduce(:+),"stringanotherStringlastString"

        assert_equal str_triple.to_a,
                        ["string", "anotherString", "lastString"]

        assert_equal int_triple.reduce(:*),6
        assert_equal str_triple.reduce(:<<),"stringanotherStringlastString"
        assert_equal str_triple.to_a, 
            ["stringanotherStringlastString", "anotherString", "lastString"]

        str_triple = Triple.new("string", "anotherString", "lastString")

        assert_equal int_triple.reduce(2,:+),8
        assert_equal int_triple.reduce(2,:*),12
    
        assert_equal str_triple.reduce("What??",:+),
            "What??stringanotherStringlastString"

        assert_equal int_triple.reduce {|memo,obj| memo + obj}, 6
        assert_equal str_triple.reduce {|memo,obj| memo + obj},
                                    "stringanotherStringlastString"
        assert_equal int_triple.reduce(2) {|memo,obj| memo + obj}, 8
        assert_equal str_triple.reduce("What??") {|memo,obj| memo + obj},
                                    "What??stringanotherStringlastString"

    end

    def test_reverse_each
        int_triple = Triple.new(1, 2, 3)
        assert_equal int_triple.reverse_each{|i| i = i+1 }.to_a,[1,2,3]
              
    end

    def test_select
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        
        assert_empty nil_triple.select{|i| i != nil}

        assert_equal int_triple.select{|i| i > 1}, [2,3]
        assert_empty int_triple.select{|i| i > 3}
    end

    def test_slice_after
        nil_triple = Triple.new
        int_triple = Triple.new("1", "2", "3")

        assert_equal nil_triple.slice_after(nil).to_a,[[nil], [nil], [nil]]
        assert_equal int_triple.slice_after(/[1-9]/).to_a,[["1"], ["2"], ["3"]]
        assert_equal int_triple.slice_after(/1/).to_a,[["1"], ["2", "3"]]
        assert_equal int_triple.slice_after(/[2-3]/).to_a,[["1", "2"], ["3"]]

        assert_equal int_triple.slice_after{|i| i.to_i > 1}.to_a,
                    [["1", "2"], ["3"]]
        assert_equal int_triple.slice_after{|i| i.to_i % 1 == 0}.to_a,
                    [["1"], ["2"], ["3"]]
    end

    def test_slice_before
        nil_triple = Triple.new
        int_triple = Triple.new("1", "2", "3")

        assert_equal int_triple.slice_before(/[1-9]/).to_a,
                                            [["1"], ["2"], ["3"]]
        assert_equal int_triple.slice_before(/1/).to_a,
                                            [["1", "2", "3"]]
        assert_equal int_triple.slice_before(/2/).to_a,
                                            [["1"], ["2", "3"]]
        assert_equal int_triple.slice_before(/[2-3]/).to_a,
                                            [["1"], ["2"], ["3"]]
        assert_equal int_triple.slice_before{|i| i.to_i > 1}.to_a,
                                            [["1"], ["2"], ["3"]]
        assert_equal int_triple.slice_before{|i| i.to_i % 2 == 0}.to_a,
                                            [["1"], ["2", "3"]]
    end

    def test_slice_when
        nil_triple = Triple.new
        int_triple = Triple.new(1,2,4)

        assert_equal nil_triple.slice_when {|a,b| a != b}.to_a,
                                            [[nil, nil, nil]]
        assert_equal int_triple.slice_when {|a,b| a + 1 != b}.to_a,
                                            [[1, 2], [4]]

        assert_equal int_triple.slice_when {|a,b| a%1 == 0}.to_a,
                                            [[1], [2], [4]]
        
    end

    def test_sort
        nil_triple = Triple.new
        int_triple = Triple.new("1", "2", "3")
        rev_triple = Triple.new("3", "2", "1")
        mix_triple = Triple.new(1, 2.5, "3")

        assert_equal nil_triple.sort{ |a,b| a <=> b },[nil,nil,nil]
        assert_equal int_triple.sort{ |a,b| a <=> b },["1", "2", "3"]
        assert_equal rev_triple.sort{ |a,b| a <=> b },["1", "2", "3"]

        assert_equal int_triple.sort{
            |a,b| -a.to_i <=> -b.to_i
            },["3", "2", "1"]
    end

    def test_sort_by
        nil_triple = Triple.new(nil,true,false)
        int_triple = Triple.new("4", "2", "3")
        mix_triple = Triple.new(1, 2.5, "3")
        str_triple = Triple.new("string", "anotherString", "lastString")

        assert_equal int_triple.sort_by{|a| a.to_i}.to_a,["2", "3", "4"]
        assert_equal str_triple.sort_by {|a| a.length}.to_a,
                                ["string", "lastString", "anotherString"]

    end

    def test_sum
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        mix_triple = Triple.new(1, 2.5, "3")
        str_triple = Triple.new("string", "anotherString", "lastString")

        assert_equal int_triple.sum(0),6
        assert_equal int_triple.sum(6),12
        assert_equal str_triple.sum(0){|e| e.length},29
        assert_equal str_triple.sum("What??"){|e| e},
                            "What??stringanotherStringlastString"
    end

    def test_take
        nil_triple = Triple.new

        assert_empty  nil_triple.take(0)
        assert_equal  nil_triple.take(1),[nil]
        assert_equal  nil_triple.take(4),[nil, nil, nil]
    end

    def test_take_while
        nil_triple = Triple.new

        assert_empty nil_triple.take_while {|i| i != nil}
        assert_equal nil_triple.take_while {|i| i == nil},[nil, nil, nil]
    end

    def test_to_a
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        mix_triple = Triple.new(1, 2.5, "3")

        assert_equal nil_triple.to_a,[nil, nil, nil]
        assert_equal int_triple.to_a,[1, 2, 3]
        assert_equal mix_triple.to_a,[1, 2.5, "3"]
    end

    def test_to_h
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 3)
        mix_triple = Triple.new(1, 2.5, "3")

        assert_equal nil_triple.each_with_index.to_h,{nil=>2}
        assert_equal int_triple.each_with_index.to_h,{1=>0, 2=>1, 3=>2}
        assert_equal mix_triple.each_with_index.to_h,{1=>0, 2.5=>1, "3"=>2}
    end

    def test_uniq
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 2)
        mix_triple = Triple.new(1, 2.5, "3")
        str_triple = Triple.new("abc","bca","cba")

        assert_equal nil_triple.uniq,[nil]
        assert_equal int_triple.uniq,[1, 2]
        assert_equal int_triple.uniq{|i| i%1},[1]
        assert_equal mix_triple.uniq,[1, 2.5, "3"]
        assert_equal str_triple.uniq{|i| i.length},["abc"]
    end

    def test_zip
        nil_triple = Triple.new
        int_triple = Triple.new(1, 2, 2)
        mix_triple = Triple.new(1, 2.5, "3")
        str_triple = Triple.new("abc","bca","cba")

        assert_equal nil_triple.zip(int_triple,str_triple,mix_triple).to_a,
                [[nil, 1, "abc", 1], [nil, 2, "bca", 2.5], [nil, 2, "cba", "3"]]

        empty_arr = []
        assert_nil int_triple.zip(int_triple) {
            |a, b| empty_arr << a + b
        }
        assert_equal empty_arr,[2, 4, 4]
    end
end



