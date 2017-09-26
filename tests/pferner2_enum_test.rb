require 'minitest/autorun'

class Pferner2Test < Minitest::Test

	# Create instances of triple to test
	def setup
		@triple_int = Triple.new(1, 2, 3)
		@triple_int_reverse = Triple.new(3, 2, 1)
		@triple_string = Triple.new("apple", "pear", "orange")
		@triple_bool_nil = Triple.new(true, false, nil)
		@triple_nil = Triple.new(nil, nil, nil)
		@triple_one = Triple.new("hi", nil, nil)
	end

	def test_all_int
		assert(@triple_int.all? { |num| num < 4 })		
	end

	def test_all_string
		assert(@triple_string.all? { |string| string.length > 1 })		
	end

	def test_all_implicit_block
		assert(@triple_int.all? )
	end

	def test_all_fail
		assert(not(@triple_string.all? { |string| string.length < 4 }))
	end

	def test_all_null_fail
		assert(not(@triple_nil.all?))
	end

	def test_any_int
		assert(@triple_int.any? { |num| num == 3})		
	end

	def test_any_implicit_block
		assert(@triple_bool_nil.any? )
	end

	def test_any_fail
		assert(not(@triple_string.all? { |string| string == "cherry"}))
	end

	def test_chunk_int
		assert_equal(@triple_int.chunk{ |n| n.even?}.to_a, [[false, [1]], [true, [2]], [false, [3]]])
	end

	def test_chunk_string
		assert_equal(@triple_string.chunk{ |s| s=="apple"}.to_a, [[true, ["apple"]], [false, ["pear", "orange"]]])
	end

	def test_chunk_while
		assert_equal(@triple_int.chunk_while { |i, j| i>j}.to_a, [[1], [2], [3]])
	end

	def test_collect
		assert_equal(@triple_int.collect {7}, [7, 7, 7])
	end

	def test_collect_2
		assert_equal(@triple_int.collect {|n| n*10}, [10, 20, 30])
	end

	def test_collect_concat_int
		assert_equal(@triple_int.collect_concat {|n| n+1}, [2, 3, 4])
	end

	def test_collect_concat_string
		assert_equal(@triple_string.collect_concat {|s| s+"s"}, ["apples", "pears", "oranges"])
	end

	def test_collect_concat
		assert_equal(@triple_int.collect_concat {|n| [n, -n]}, [1, -1, 2, -2, 3, -3])
	end

	def test_count
		assert_equal(@triple_int.count, 3)
	end

	def test_count_argument
		assert_equal(@triple_int.count(2), 1)
	end

	def test_count_block
		assert_equal(@triple_int.count{|x| x.even?}, 1)
	end

	def test_cycle
		assert_nil(@triple_int.cycle(2) {|n| n})
	end

	def test_detect
		assert_equal((@triple_int).detect {|x| not(x.even?) and x > 2}, 3)
	end

	def test_detect_nil
		assert_nil(@triple_int.detect(ifnone=nil) {|x| not(x.even?) and x.even?})
	end

	def test_drop
		assert_equal(@triple_string.drop(2), ["orange"])
	end

	def test_drop_while_string
		assert_equal(@triple_string.drop_while {|string| string.include?("a")}, [])
	end

	def test_drop_while_int
		assert_equal(@triple_int.drop_while {|n| n < 2}, [2, 3])
	end

	def test_each_cons
		assert_nil(@triple_int.each_cons(2) {|n| n})
	end

	def test_each_entry
		assert_equal(@triple_int.each_entry {|n| n}.to_a, [1, 2, 3])
	end

	def test_each_slice
		assert_nil(@triple_int.each_slice(2) {|n| n})
	end

	# def test_each_with_index_int
	# 	assert_equal(@triple_int.each_with_index.to_h {|n, i|}, {1=>0, 2=>1, 3=>2})
	# end

	# def test_each_with_index_string
	# 	assert_equal(@triple_string.each_with_index.to_h {|n, i|}, {"apple"=>0, "pear"=>1, "orange"=>2})
	# end

	def test_each_with_object
		obj = @triple_int.each_with_object([]) { |n, a| a << n*5 }
		assert_equal(obj, [5, 10, 15])
	end

	def test_entries
		assert_equal(@triple_int.entries(), [1, 2, 3])
	end

	def test_find
		assert_equal(@triple_int.find {|n| n < 3 and n > 1}, 2)
	end

	def test_find_nil
		assert_nil(@triple_int.find {|n| n > 3 and n < 1})
	end

	def test_find_if_none
		assert_nil(@triple_int.find(if_none = nil) {|n| n > 3 and n < 1})
	end

	def test_find_all
		assert_equal(@triple_int.find_all {|n| n < 3}, [1, 2])
	end

	def test_find_index_block
		assert_equal(@triple_int.find_index {|n| n%2==0}, 1)
	end

	def test_find_index_argument
		assert_equal(@triple_int.find_index(2), 1)
	end

	def test_first
		assert_equal(@triple_string.first, "apple")
	end

	def test_first_argument
		assert_equal(@triple_string.first(2), ["apple", "pear"])
	end

	def test_flat_map_int
		assert_equal(@triple_int.flat_map {|n| n+1}, [2, 3, 4])
	end

	def test_flat_map_string
		assert_equal(@triple_string.flat_map {|s| s+"s"}, ["apples", "pears", "oranges"])
	end

	def test_flat_map_2
		assert_equal(@triple_int.flat_map {|n| [n, n+1]}, [1, 2, 2, 3, 3, 4])
	end

	def test_grep
		assert_equal(@triple_int.grep(2..3), [2, 3])
	end

	def test_grep_block
		assert_equal(@triple_int.grep(2..3) {|n| n+10}, [12, 13])
	end

	def test_grep_v
		assert_equal(@triple_int.grep_v(2..3), [1])
	end

	def test_grep_block_v
		assert_equal(@triple_int.grep_v(2..3) {|n| n+10}, [11])
	end

	def test_group_by
		assert_equal(@triple_int.group_by {|n| n.even?}, {false=>[1, 3], true=>[2]})
	end

	def test_include
		assert(@triple_int.include?(3))
	end

	def test_inject_initial_sym
		assert_equal(@triple_int.inject(1, :+), 7)
	end

	def test_inject_sym
		assert_equal(@triple_int.inject(:*), 6)
	end

	def test_inject_initial
		assert_equal(@triple_int.inject(1) {|n, m| n * m}, 6)
	end

	def test_inject_block
		assert_equal(@triple_int.inject() {|n, m| n + m + 1}, 8)
	end

	def test_map
		assert_equal(@triple_int.map {|n| n+1}, [2, 3, 4])
	end

	def test_max_int
		assert_equal(@triple_int.max, 3)
	end

	def test_max_string
		assert_equal(@triple_string.max, "pear")
	end

	def test_max_block
		assert_equal(@triple_string.max {|a, b| a.length <=> b.length}, "orange")
	end

	def test_max_argument
		assert_equal(@triple_string.max(2), ["pear", "orange"])
	end

	def test_max_argument_block
		assert_equal(@triple_string.max(2) {|a, b| a.length <=> b.length}, ["orange", "apple"])
	end 

	def test_max_by_block
		assert_equal(@triple_string.max_by {|s| s.length}, "orange")
	end

	def test_max_by
		assert_equal(@triple_string.max_by {|s| s.length}, "orange")
	end

	def test_member
		assert(@triple_int.member?(3))
	end

	def test_min_int
		assert_equal(@triple_int.min, 1)
	end

	def test_min_string
		assert_equal(@triple_string.min, "apple")
	end

	def test_min_block
		assert_equal(@triple_string.min {|a, b| a.byteslice(1) <=> b.byteslice(1)}, "pear")
	end

	def test_min_argument
		assert_equal(@triple_string.min(2), ["apple", "orange"])
	end

	def test_min_argument_block
		assert_equal(@triple_string.min(2) {|a, b| a.byteslice(1) <=> b.byteslice(1)}, ["pear", "apple"])
	end 

	def test_minmax
		assert_equal(@triple_string.minmax, ["apple", "pear"])
	end

	def test_minmax_block
		assert_equal(@triple_string.minmax {|a, b| a.byteslice(1) <=> b.byteslice(1)}, ["pear", "orange"])
	end

	def test_minmax_by
		assert_equal(@triple_string.minmax_by {|s| s.length}, ["pear", "orange"])
	end

	def test_none_true
		assert(@triple_nil.none?)
	end

	def test_none_false
		assert(not(@triple_int.none?))
	end

	def test_none_block
		assert(@triple_int.none? {|n| n.even? and n<2})
	end

	def test_one_true
		assert(@triple_one.one?)
	end

	def test_one_false
		assert(not(@triple_nil.one?))
	end

	def test_one_block
		assert(@triple_int.one? {|n| n.even?})
	end

	def test_partition
		assert_equal(@triple_int.partition {|n| n<2}, [[1], [2, 3]])
	end

	def test_reduce_initial_sym
		assert_equal(@triple_int.reduce(1, :+), 7)
	end

	def test_reduce_sym
		assert_equal(@triple_int.reduce(:*), 6)
	end

	def test_reduce_initial
		assert_equal(@triple_int.reduce(1) {|n, m| n * m}, 6)
	end

	def test_reduce_block
		assert_equal(@triple_int.reduce() {|n, m| n + m + 1}, 8)
	end

	def test_reject
		assert_equal(@triple_int.reject {|n| n==1 or n.even?}, [3])
	end

	# def test_reverse_each
	# 	assert_equal(@triple_int.reverse_each {|n| p n}, [3, 2, 1])
	# end

	def test_select
		assert_equal(@triple_int.select {|n| n%2==0}, [2])
	end

	def test_slice_after
		assert_equal(@triple_string.slice_after("pear").to_a, [["apple", "pear"], ["orange"]])
	end

	def test_slice_before
		assert_equal(@triple_string.slice_before("pear").to_a, [["apple"], ["pear", "orange"]])
	end

	def test_sort
		assert_equal(@triple_int_reverse.sort, [1, 2, 3])
	end

	def test_sort_block
		assert_equal(@triple_string.sort {|s, t| s.length <=> t.length}, ["pear", "apple", "orange"])
	end

	def test_sort_by
		assert_equal(@triple_string.sort_by {|s| s.length}, ["pear", "apple", "orange"])
	end

	def test_sum
		assert_equal(@triple_int.sum, 6)
	end

	def test_sum_block
		assert_equal(@triple_int.sum {|n| n * 3}, 18)
	end

	def test_sum_init
		assert_equal(@triple_int.sum(init=0) {|n| n * 3}, 18)
	end

	def test_take
		assert_equal(@triple_int.take(2), [1, 2])
	end

	def test_take_while
		assert_equal(@triple_int.take_while {|n| n<2}, [1])
	end

	def test_to_a
		assert_equal(@triple_int.to_a, [1, 2, 3])
	end

	# def test_to_h
	# 	assert_equal(@triple_int.each_with_index.to_h, {1=>0, 2=>1, 3=>2})
	# end

	def test_uniq
		assert_equal(@triple_int.uniq, [1, 2, 3])
	end

	def test_zip
		assert_equal(@triple_int.zip(@triple_int_reverse), [[1, 3], [2, 2], [3, 1]])
	end

	def test_zip_block
		assert_nil(@triple_int.zip(@triple_int_reverse) {|n| n})
	end
end








