require 'minitest/autorun'

describe Enumerable do

    before do
        @triple = Triple.new(4, 2, 3)
    end

    # any?
    describe "all?" do
        it "returns true for value check" do
            result = @triple.all?{ |x| x < 5 }
            result.must_equal true
        end

        it "returns false for value check" do
            result = @triple.all?{ |x| x > 5 }
            result.must_equal false
        end
    end
    
    # any?
    describe "any?" do
        it "returns true for value check" do
            result = @triple.any? { |x| x == 2 }
            result.must_equal true
        end

        it "returns false for value check" do
            result = @triple.any?{ |x| x == 7 }
            result.must_equal false
        end
    end

    # chunk
    describe "chunk" do
        it "returns chunking of even numbers" do
            result = @triple.chunk { |x| x.even? }
            result.to_a.must_equal [[true, [4, 2]], [false, [3]]]
        end
    end

    # chunk_while
    describe "chunk_while" do
        it "returns chunking" do
            result = @triple.chunk_while{ |x, y| x + y == 6 }
            result.to_a.must_equal [[4, 2], [3]]
        end
    end

    # collect
    describe "collect" do
        it "returns squared list" do
            result = @triple.collect { |x| x * x }
            result.must_equal [16, 4, 9]
        end
    end

    # collect_concat
    describe "collect_concat" do
        it "returns array with positive and negative values" do
            result = @triple.collect_concat { |x| [x, -x] }
            result.must_equal [4, -4, 2, -2, 3, -3]
        end
    end

    # count
    describe "count" do
        it "returns number of elements" do
            result = @triple.count
            result.must_equal 3
        end

        it "returns number of 2's" do
            result = @triple.count(2)
            result.must_equal 1
        end

        it "returns number of even elements" do
            result = @triple.count { |x| x.even? }
            result.must_equal 2
        end
    end

    # detect
    describe "detect" do
        it "returns with correct value" do
            result = @triple.detect { |x| x == 2 }
            result.must_equal 2
        end

        it "returns nil for not found" do
            result = @triple.detect { |x| x == 7 }
            assert_nil result
        end
    end

    # drop
    describe "drop" do
        it "returns array with first dropped" do
            result = @triple.drop(1)
            result.must_equal [2, 3]
        end
    end

    # drop_while
    describe "drop_while" do
        it "returns array with first dropped" do
            result = @triple.drop_while{ |x| x != 2 }
            result.must_equal [2, 3]
        end
    end

    # # each_with_index
    # describe "each_with_index" do
    #     it "return iterator of items and indecies" do
    #         result = @triple.each_with_index
    #         result.to_a.must_equal [[4, 0], [2, 1], [3, 2]]
    #     end
    # end

    # each_with_object
    describe "each_with_object" do
        it "return " do
            result = @triple.each_with_object([]) { |x, y| y << x * x }
            result.must_equal [16, 4, 9]
        end
    end

    # entries
    describe "entries" do
        it "returns list of entries" do
            result = @triple.entries
            result.must_equal [4, 2, 3]
        end
    end

    # find
    describe "find" do
        it "returns with correct value" do
            result = @triple.find { |x| x == 3 }
            result.must_equal 3
        end

        it "returns nil for not found" do
            result = @triple.find { |x| x == 8 }
            assert_nil result
        end
    end

    # find_all
    describe "find_all" do
        it "returns both even numbers" do
            result = @triple.find_all { |x| x % 2 == 0 }
            result.must_equal [4, 2]
        end
    end

    # find_index
    describe "find_index" do
        it "returns index of 2" do
            result = @triple.find_index { |x| x == 2 }
            result.must_equal 1
        end

        it "returns index of 4" do
            result = @triple.find_index(4)
            result.must_equal 0
        end
    end

    # first
    describe "first" do
        it "returns first" do
            result = @triple.first
            result.must_equal 4
        end

        it "returns first and second" do
            result = @triple.first(2)
            result.must_equal [4, 2]
        end
    end

    # flat_map
    describe "flat_map" do
        it "returns negative mapping array" do
            result = @triple.flat_map { |x| -x }
            result.must_equal [-4, -2, -3]
        end

        it "returns array with positive and negative values" do
            result = @triple.flat_map { |x| [x, -x] }
            result.must_equal [4, -4, 2, -2, 3, -3]
        end
    end

    # grep
    describe "grep" do
        it "returns elements in pattern range" do
            result = @triple.grep(2..3) 
            result.must_equal [2, 3]
        end

        it "returns elements in pattern squared" do
            result = @triple.grep(2..3) { |x| x * x }
            result.must_equal [4, 9]
        end
    end

    # grep_v
    describe "grep_v" do
        it "returns elements not in range" do
            result = @triple.grep_v(2..3) 
            result.must_equal [4]
        end

        it "returns elements in pattern squared" do
            result = @triple.grep_v(2..3) { |x| x * x }
            result.must_equal [16]
        end    
    end

    # group_by
    describe "group_by" do
        it "returns odd and even groups" do
            result = @triple.group_by { |x| x % 2 }
            result.to_a.must_equal [[0, [4, 2]], [1, [3]]]
        end
    end

    # include?
    describe "include" do
        it "returns true for included object" do
            result = @triple.include?(4)
            result.must_equal true
        end
        it "returns false for other object" do
            result = @triple.include?(7)
            result.must_equal false
        end
    end

    # inject
    describe "inject" do
        it "returns the sum of all numbers" do
            result = @triple.inject { |total, x| total + x }
            result.must_equal 9
        end

        it "returns sum of list" do
            result = @triple.inject(:+)
            result.must_equal 9
        end
 
        it "returns the sum of all numbers plus 6" do
            result = @triple.inject(6) { |total, x| total + x }
            result.must_equal 15
        end

        it "returns sum of list plus 6" do
            result = @triple.inject(6, :+)
            result.must_equal 15
        end
    end

    #map
    describe "map" do
        it "returns squared values" do
            result = @triple.map{ |x| x*x }
            result.must_equal [16,4,9]
        end
    end

    # max
    describe "max" do
        it "returns max element" do
            result = @triple.max
            result.must_equal 4
        end

        it "returns max element with negative comparison" do
            result = @triple.max { |x, y| -x <=> -y}
            result.must_equal 2
        end

        it "returns 2 max elements" do
            result = @triple.max(2)
            result.must_equal [4, 3]
        end

        it "returns 2 max elements with negative comparison" do
            result = @triple.max(2) { |x, y| -x <=> -y}
            result.must_equal [2, 3]
        end
    end

    # max_by
    describe "max_by" do
        it "returns negative max" do
            result = @triple.max_by { |x| -x }
            result.must_equal 2
        end

        it "returns 2 negative maxs" do
            result = @triple.max_by(2) { |x| -x }
            result.must_equal [2, 3]
        end
    end

    # member?
    describe "member" do
        it "returns true for included object" do
            result = @triple.member?(3)
            result.must_equal true
        end
        it "returns false for other object" do
            result = @triple.member?(9)
            result.must_equal false
        end
    end

    # min
    describe "min" do
        it "returns min element" do
            result = @triple.min
            result.must_equal 2
        end

        it "returns min element with negative comparison" do
            result = @triple.min { |x, y| -x <=> -y}
            result.must_equal 4
        end

        it "returns 2 min elements" do
            result = @triple.min(2)
            result.must_equal [2, 3]
        end

        it "returns 2 min elements with negative comparison" do
            result = @triple.min(2) { |x, y| -x <=> -y}
            result.must_equal [4, 3]
        end
    end
    
    # min_by
    describe "min_by" do
        it "returns min negative element" do
            result = @triple.min_by { |x| -x }
            result.must_equal 4
        end

        it "returns min negative element" do
            result = @triple.min_by(2) { |x| -x }
            result.must_equal [4, 3]
        end
    end

    # minmax
    describe "minmax" do
        it "returns min and max" do
            result = @triple.minmax
            result.must_equal [2, 4]
        end

        it "returns 2 min elements with negative comparison" do
            result = @triple.minmax { |x, y| -x <=> -y}
            result.must_equal [4, 2]
        end
    end

    # minmax_by
    describe "minmax_by" do
        it "returns negative min and max" do
            result = @triple.minmax_by { |x| -x }
            result.must_equal [4, 2]
        end
    end

    # none?
    describe "none?" do
        it "returns true for no given number" do
            result = @triple.none? { |x| x == 8 }
            result.must_equal true
        end

        it "returns false for finding member number" do
            result = @triple.none? { |x| x == 4 }
            result.must_equal false
        end
    end

    # one?
    describe "one?" do
        it "returns true for one odd number" do
            result = @triple.one? { |x| x % 2 == 1 }
            result.must_equal true
        end

        it "returns false for miltiple even numbers" do
            result = @triple.one? { |x| x % 2 == 0 }
            result.must_equal false
        end
    end

    # partition
    describe "partition" do
        it "returns even and odd partition" do
            result = @triple.partition { |x| x % 2 == 0 }
            result.must_equal [[4, 2], [3]]
        end
    end

    # reduce
    describe "reduce" do
        it "returns the sum of all numbers" do
            result = @triple.reduce { |total, x| total + x }
            result.must_equal 9
        end

        it "returns sum of list" do
            result = @triple.reduce(:+)
            result.must_equal 9
        end
 
        it "returns the sum of all numbers plus 6" do
            result = @triple.reduce(6) { |total, x| total + x }
            result.must_equal 15
        end

        it "returns sum of list plus 6" do
            result = @triple.reduce(6, :+)
            result.must_equal 15
        end
    end

    # reject
    describe "reject" do
        it "returns all even numbers" do
            result = @triple.reject { |x| x % 2 == 1 }
            result.must_equal [4, 2]
        end
    end

    # reverse_each
    describe "reverse_each" do
        it "returns reverse contents" do
            result = @triple.reverse_each
            result.to_a.must_equal [3, 2, 4]
        end
    end

    # select
    describe "select" do
        it "returns all even numbers" do
            result = @triple.select { |x| x % 2 == 0 }
            result.must_equal [4, 2]
        end
    end

    # slice_after
    describe "slice_after" do
        it "returns sliced after element" do
            result = @triple.slice_after { |x| x == 2 }
            result.to_a.must_equal [[4, 2], [3]]
        end

        it "returns sliced after pattern" do
            result = @triple.slice_after(3)
            result.to_a.must_equal [[4, 2, 3]]
        end
    end

    # slice_before
    describe "slice_before" do
        it "returns sliced before element" do
            result = @triple.slice_before { |x| x == 2 }
            result.to_a.must_equal [[4], [2, 3]]
        end

        it "returns sliced before pattern" do
            result = @triple.slice_before(3)
            result.to_a.must_equal [[4, 2], [3]]
        end
    end

    # slice_when
    describe "slice_when" do
        it "returns sliced between elements" do
            result = @triple.slice_when{ |x, y| x + y == 6 }
            result.to_a.must_equal [[4], [2, 3]]
        end
    end

    # sort
    describe "sort" do
        it "returns sorted list" do
            result = @triple.sort
            result.must_equal [2, 3, 4]
        end

        it "returns reverse sorted list" do
            result = @triple.sort { |x, y| y <=> x }
            result.must_equal [4, 3, 2]
        end
    end

    # sort_by
    describe "returns backwards sorted list" do
        it "sort_by" do
            result = @triple.sort_by { |x| -x }
            result.must_equal [4, 3, 2]
        end
    end

    # sum
    describe "sum" do
        it "returns sum" do
            result = @triple.sum
            result.must_equal 9
        end

        it "returns doubled sum" do
            result = @triple.sum { |x| x * 2 }
            result.must_equal 18
        end
    end

    # take
    describe "take" do
        it "returns first and second" do
            result = @triple.take(2)
            result.must_equal [4, 2]
        end
    end

    # take_while
    describe "take_while" do
        it "returns until it finds 3" do
            result = @triple.take_while { |x| x != 3 }
            result.must_equal [4, 2]
        end
    end

    # to_a
    describe "to_a" do
        it "returns array with contents" do
            result = @triple.to_a
            result.must_equal [4, 2, 3]
        end
    end

    # # to_h
    # describe "to_h" do
    #     it "returns hash of elements with id" do
    #         result = @triple.each_with_index.to_h
    #         result.to_a.must_equal [[4, 0], [2, 1], [3, 2]]
    #     end
    # end

    # uniq
    describe "uniq" do
        it "returns array without duplicates" do
            temp = Triple.new(4, 4, 3)
            result = temp.uniq
            result.must_equal [4, 3]
        end

        it "returns array without negative duplicates" do
            temp = Triple.new(4, -4, 3)
            result = temp.uniq { |x| x * x }
            result.must_equal [4, 3]
        end
    end

    # zip
    describe "zip" do
        it "returns zipped array of arrays" do
            result = @triple.zip([0, 1, 2])
            result.must_equal [[4, 0], [2, 1], [3, 2]]
        end

        it "returns tripple zipped array of arrays" do
            result = @triple.zip([0, 1, 2], [0, 1, 2])
            result.must_equal [[4, 0, 0], [2, 1, 1], [3, 2, 2]]
        end

        it "changes input array" do
            result = []
            @triple.zip([0, 1, 2]) { |x, y| result << [x, y]}
            result.must_equal [[4, 0], [2, 1], [3, 2]]
        end

        it "changes input array with two zipped arrays" do
            result = []
            @triple.zip([0, 1, 2], [0, 1, 2]) { |x, y, z| result << [x, y, z]}
            result.must_equal [[4, 0, 0], [2, 1, 1], [3, 2, 2]]
        end
    end

end