require "minitest/autorun"

class TestTriple < Minitest::Test

  def setup
    @triple1 = Triple.new(1,2,3)
    @triple2 = Triple.new("1","2","3")
    @triple3=Triple.new(nil,nil,nil)
    @triple4=Triple.new(1,"1",2)
    @triple5=Triple.new(1,2,nil)
    @triple6=Triple.new(1,"2",nil)
    @triple7=Triple.new(1,2.2,3.55)
  end

  def test_all
    assert_equal true, @triple1.all?{|x| x.is_a?(Numeric)}
    assert_equal false, @triple2.all?{|x| x.is_a?(Numeric)}
    assert_equal false, @triple3.all?{|x| x.is_a?(Numeric)}
    assert_equal false, @triple4.all?{|x| x.is_a?(Numeric)}
    assert_equal false, @triple5.all?{|x| x.is_a?(Numeric)}
    assert_equal false, @triple6.all?{|x| x.is_a?(Numeric)}
    assert_equal true, @triple7.all?{|x| x.is_a?(Numeric)}
  end

  def test_any
    assert_equal true, @triple1.any?{|x| x.is_a?(Numeric)}
    assert_equal false, @triple2.any?{|x| x.is_a?(Numeric)}
    assert_equal false, @triple3.any?{|x| x.is_a?(Numeric)}
    assert_equal true, @triple4.any?{|x| x.is_a?(Numeric)}
    assert_equal true, @triple5.any?{|x| x.is_a?(Numeric)}
    assert_equal true, @triple6.any?{|x| x.is_a?(Numeric)}
    assert_equal true, @triple7.any?{|x| x.is_a?(Numeric)}
  end

  def test_chunk
    # assert_equal [[true,[1]],[false,["1"]],[true,[2]]], @triple4.test_chunk(@triple4.get_arr)
    # assert_equal [[true,[1,2,3]]], @triple1.test_chunk(@triple1.get_arr)
    # assert_equal [[false,["1","2","3"]]], @triple2.test_chunk(@triple2.get_arr)
    # assert_equal [[false,[nil,nil,nil]]], @triple3.test_chunk(@triple3.get_arr)

    # assert_equal [[true,[1,2]],[false,[nil]]], @triple1.test_chunk(@triple5.get_arr)
    # assert_equal [[true,[1]],[false,["2",nil]]], @triple1.test_chunk(@triple6.get_arr)
    # assert_equal [[true,[1,2.2,3.55]]], @triple1.test_chunk(@triple7.get_arr)
  end

  def test_chunk_while
    # assert_equal [[1,2,3]], @triple1.test_chunck_while(@triple1.get_arr)
    # assert_equal [[1],[2.2],[3.55]], @triple1.test_chunck_while(@triple7.get_arr)
  end

  def test_collect
    # assert_equal ["cat","cat","cat"], @triple1.get_arr.collect{"cat"}
    # assert_equal ["cat","cat","cat"], @triple2.get_arr.collect{"cat"}
    # assert_equal ["cat","cat","cat"], @triple3.get_arr.collect{"cat"}
    # assert_equal ["cat","cat","cat"], @triple4.get_arr.collect{"cat"}
    # assert_equal ["cat","cat","cat"], @triple5.get_arr.collect{"cat"}
    # assert_equal ["cat","cat","cat"], @triple6.get_arr.collect{"cat"}
    # assert_equal ["cat","cat","cat"], @triple7.get_arr.collect{"cat"}
  end

  def test_collect_concat
    # assert_equal [1,1,2,2,3,3], @triple1.get_arr.collect_concat{|e|[e,e]}
    # assert_equal ["1","1","2","2","3","3"], @triple2.get_arr.collect_concat{|e|[e,e]}
    # assert_equal [nil,nil,nil,nil,nil,nil], @triple3.get_arr.collect_concat{|e|[e,e]}
  end

  def test_count
    # assert_equal 3, @triple1.get_arr.count
    # assert_equal 3, @triple2.get_arr.count
    # assert_equal 3, @triple3.get_arr.count
    # assert_equal 3, @triple4.get_arr.count
    # assert_equal 3, @triple5.get_arr.count
    # assert_equal 3, @triple6.get_arr.count
    # assert_equal 3, @triple7.get_arr.count
  end

  def test_cycle
    # assert_equal [1,2,3,1,2,3], @triple1.test_cycle(@triple1.get_arr)
    # assert_equal ["1","2","3","1","2","3"], @triple2.test_cycle(@triple2.get_arr)
    # assert_equal [nil,nil,nil,nil,nil,nil], @triple3.test_cycle(@triple3.get_arr)
  end

  def test_detect
    # assert_equal @triple1.get_arr.detect{|e|e%2==0}, 2
    # assert_equal @triple2.get_arr.detect{|e|e%2==0}, nil
  end

  def test_drop
    assert_equal @triple1.drop(3),[]
    assert_equal @triple2.drop(3),[]
    assert_equal @triple3.drop(2),[nil]
  end

  def test_drop_while
    assert_equal @triple1.drop_while{|e|e<2},[2,3]
  end

  def test_each_cons

    assert_equal @triple1.each_cons(3).to_a,[[1,2,3]]
    assert_equal @triple2.each_cons(3).to_a,[["1","2","3"]]
    assert_equal @triple3.each_cons(2).to_a,[[nil,nil],[nil,nil]]
  end

  def test_each_entry

    # assert_equal @triple1.test_each_entry(@triple1.get_arr), [1,2,3]
    # assert_equal @triple1.test_each_entry(@triple2.get_arr), ["1","2","3"]
    # assert_equal @triple1.test_each_entry(@triple3.get_arr), [nil,nil,nil]
  end

  def test_each_slice

    assert_equal @triple1.each_slice(2).to_a,[[1,2],[3]]
    assert_equal @triple2.each_slice(2).to_a,[["1","2"],["3"]]
    assert_equal @triple3.each_slice(2).to_a,[[nil,nil],[nil]]
  end

  def test_each_with_index
    hash = Hash.new
    @triple1.each_with_index {|item,index | hash[item]=index}
    assert_equal hash[1],0
    @triple2.each_with_index {|item,index | hash[item]=index}
    assert_equal hash["1"],0
    @triple3.each_with_index {|item,index | hash[item]=index}
    assert_equal hash[nil],2
  end

  def test_each_with_object
    assert_equal @triple1.each_with_object([]){|i,a|a<<i*2},[2,4,6]
  end

  def test_entries
    # assert_equal @triple1.get_arr.to_a, [1,2,3]
    # assert_equal @triple2.get_arr.to_a, ["1","2","3"]
    # assert_equal @triple3.get_arr.to_a, [nil,nil,nil]
  end

  def test_find
    # assert_equal @triple1.get_arr.find{|e|e%2==0}, 2
    # assert_nil @triple2.get_arr.find{|e|e%2==0}
  end

  def test_find_all
    assert_equal @triple1.find_all{|i|i%2==1},[1,3]
  end

  def test_find_index
    # assert_equal @triple1.get_arr.find_index{|i|i==2},1
  end

  def test_first
    assert_equal @triple1.first,1
    assert_nil @triple3.first
  end

  def test_flat_map
    assert_equal @triple1.flat_map{|e|[e,-e]}, [1,-1,2,-2,3,-3]
  end

  def test_grep
    # assert_equal @triple1.get_arr.grep(2),[2]
    # assert_equal @triple3.get_arr.grep(nil),[nil,nil,nil]
  end

  def test_grep_v
    # assert_equal @triple1.get_arr.grep_v(2),[1,3]
    # assert_equal @triple3.get_arr.grep_v(nil),[]
  end

  def test_group_by
    assert_equal @triple1.group_by{|i|i%2==0},{false=>[1, 3], true=>[2]}
    assert_equal @triple3.group_by{|i|i==nil},{true=>[nil,nil,nil]}
  end

  def test_include?
    assert_equal @triple1.include?(1),true
    assert_equal @triple2.include?(1),false
  end

  def test_inject
    assert_equal @triple1.inject{|sum,n|sum+n}, 6
  end

  # def test_lazy
  #   #???
  #   assert_equal @triple1.lazy.to_a,[1,2,3]
  # end

  def test_map
    assert_equal @triple1.map{|i|i*2},[2,4,6]
  end

  def test_max
    assert_equal @triple1.max(2),[3,2]
    assert_equal @triple7.max,3.55
  end

  def test_max_by
    assert_equal @triple7.max_by{|x|x},3.55
    assert_equal @triple2.max_by{|x|x.length},"1" #???
  end

  def test_member?
    assert_equal @triple1.member?(1),true
    assert_equal @triple2.member?(1),false
  end

  def test_min
    assert_equal @triple1.min, 1
    assert_equal @triple7.min(2),[1,2.2]
  end

  def test_min_by
    assert_equal @triple7.min_by{|x|x},1
    assert_equal @triple2.min_by{|x|x.length},"1" #???
  end

  def test_minmax
    assert_equal @triple1.minmax{|a,b|a<=>b},[1,3] #a<=>b???
  end

  def test_none?
    assert_equal @triple1.none?{|x|x==1},false
    assert_equal @triple3.none?{|x|x==1},true
  end

  def test_minmax_by
    assert_equal @triple1.minmax_by{|a|a},[1,3]
  end

  def test_one?
    assert_equal @triple1.one?{|x|x==1},true
    assert_equal @triple7.one?{|x|x==0},false
  end

  def test_reduce
    # assert_equal @triple1.get_arr.reduce(:+), 6
  end

  def test_partition
    # assert_equal @triple1.get_arr.partition{|x|x>1},[[2,3],[1]]
    # assert_equal @triple3.get_arr.partition{|x|x==nil},[[nil,nil,nil],[]]
  end

  def test_reject
    assert_equal @triple1.reject{|x|x%2==0},[1,3]
  end

  def test_reverse_each
    assert_equal @triple1.reverse_each.to_a,[3,2,1]
    assert_equal @triple2.reverse_each.to_a,["3","2","1"]
  end

  def test_select
    assert_equal @triple1.select{|x|x%2==0},[2]
    assert_equal @triple7.select{|x|x%2==0},[]
  end

  def test_slice_after
    assert_equal @triple1.slice_after(1).to_a,[[1],[2,3]]
  end

  def test_slice_before
    assert_equal @triple1.slice_before(2).to_a,[[1],[2,3]]
  end

  def test_slice_when
    assert_equal @triple1.slice_when{|x|x%2==0}.to_a,[[1,2],[3]]

  end

  def test_sort
    assert_equal @triple1.sort,[1,2,3]
    assert_equal @triple7.sort,[1,2.2,3.55]
  end

  def test_sort_by
    assert_equal @triple1.sort_by{|x|x},[1,2,3]
    assert_equal @triple7.sort_by{|x|x},[1,2.2,3.55]
  end

  def test_sum
    assert_equal @triple1.sum,6
    assert_equal @triple7.sum,6.75
  end

  def test_take
    assert_equal @triple1.take(1),[1]
    assert_equal @triple3.take(2),[nil,nil]
  end

  def test_take_while
    assert_equal @triple1.take_while{|x|x<2},[1]
    assert_equal @triple7.take_while{|x|x%3==0},[]
  end

  def test_to_h
    assert_equal @triple1.each_with_index.to_h,{1=>0, 2=>1, 3=>2}
  end

  def test_uniq
    assert_equal @triple1.uniq,[1,2,3]
    assert_equal @triple3.uniq,[nil]
  end

  def test_zip
    b=[7,8,9]
    assert_equal @triple1.zip(b),[[1,7],[2,8],[3,9]]
    assert_equal @triple3.zip(b),[[nil,7],[nil,8],[nil,9]]
  end
end