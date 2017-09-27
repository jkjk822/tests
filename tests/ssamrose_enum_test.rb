
#require_relative "samrose_enum_class"
#require_relative "samrose_enum_class_none"
require "test/unit"

class Tester < Test::Unit::TestCase
	def test_all
		items = Triple.new(1, 2, 3) 
		assert_equal(true, items.all?)
	end
	def test_all_block
		items = Triple.new(1, 2, 3) 
		assert_equal(false, items.all?{|x| x > 1})
		assert_equal(true, items.all?{|x| x >= 1})
	end
	def test_all_str
		items = Triple.new("hello", "hi", "ciao") 
		assert_equal(false, items.all?{|x| x.length > 3})
	end
	def test_all_none
		items = Triple2.new() 
		#assert_equal(true, items.all?)
	end
	def test_any
		items = Triple.new(1, 2, 3) 
		assert_equal(true, items.any?)
	end
	def test_any_block
		items = Triple.new(1, 2, 3) 
		assert_equal(false, items.any?{|x| x < 1})
		assert_equal(true, items.any?{|x| x <= 1})
	end
	def test_any_str
		items = Triple.new("hello", "hi", "ciao") 
		assert_equal(true, items.any?{|x| x.length > 3})
	end
	def test_any_none
		items = Triple2.new() 
		#assert_equal(false, items.any?)
	end
	def test_chunk
		items = Triple.new(1, 2, 3) 
		assert_equal([[false,[1]], [true, [2,3]]], items.chunk{|x| x>1}.to_a)
	end
	def test_chunk_none
		items = Triple2.new() 
		#assert_equal([], items.chunk{|x| x>1}.to_a)
	end
	def test_chunk_while
		items = Triple.new(1, 2, 3) 
		assert_equal([[1, 2, 3]], items.chunk_while{|x, y| x+1 == y}.to_a)
	end
	def test_chunk_while_none
		items = Triple2.new() 
		#assert_equal([], items.chunk_while{|x, y| x+1 == y}.to_a)
	end
	def test_collect
		items = Triple.new(1, 2, 3) 
		assert_equal(["hi", "hi", "hi"], items.collect{"hi"})
	end
	def test_collect_block
		items = Triple.new(1, 2, 3) 
		assert_equal([2,4,6], items.collect{|x| x*2})
	end
	def test_collect_concat_block
		items = Triple.new(1, 2, 3) 
		assert_equal([1, 2, 2, 4, 3, 6], items.collect_concat{|x| [x, x*2]})
	end
	def test_count
		items = Triple.new(1, 2, 3) 
		assert_equal(3, items.count)
	end
	def test_count_n
		items = Triple.new(1, 2, 3) 
		assert_equal(1, items.count(2))
	end
	def test_count_block
		items = Triple.new(1, 2, 3) 
		assert_equal(1, items.count{|x| x.even?})
	end
	def test_count_none
		items = Triple2.new() 
		#assert_equal(0, items.count)
	end
	def test_cycle
		items = Triple.new(1, 2, 3) 
		assert_equal([1, 2, 3, 1, 2, 3], items.cycle(2).to_a)
	end
	def test_cycle_none
		items = Triple2.new() 
		#assert_equal([], items.cycle(2).to_a)
	end
	def test_cycle_block
		items = Triple.new(1, 2, 3) 
		#assert_equal([1, 2, 1, 2], items.count(2){|x| x<3}.to_a)
	end
	def test_detect
		items = Triple.new(1, 2, 3) 
		assert_equal(1, items.detect{|x| x<3})
	end
	def test_detect_none
		items = Triple.new(1, 2, 3) 
		assert_equal(nil, items.detect{|x| x<1})
	end
	def test_drop_n
		items = Triple.new(1, 2, 3) 
		assert_equal([3], items.drop(2))
	end
	def test_drop_while_block
		items = Triple.new(1, 2, 3) 
		assert_equal([2,3], items.drop_while{|x| x<2})
	end
	def test_drop_while_block_none
		items = Triple.new(1, 2, 3) 
		assert_equal([], items.drop_while{|x| x<5})
	end
	def test_each_cons_n
		items = Triple.new(1, 2, 3) 
		assert_equal([[1,2],[2,3]], items.each_cons(2).to_a)
	end
	def test_each_cons_n_block
		items = Triple.new(1, 2, 3) 
		#enum = items.each_cons(2)
		#assert_equal([[1,2],[2,3]], enum.each{|x| x>1})
	end
	def test_each_entry
		items = Triple.new(1, 2, 3) 
		#assert_equal([1,[1,2],nil], items.each_entry{|x|}.to_a)
	end
	def test_each_slice_n_block
		items = Triple.new(1, 2, 3) 
		assert_equal([[1,2],[3]], items.each_slice(2).to_a)
	end
	def test_each_slice_n_block_none
		items = Triple2.new() 
		#assert_equal(nil, items.each_slice(2){})
	end
	def test_each_with_index_block
		items = Triple.new(1, 2, 3) 
		assert_equal([1,2,3], items.each_with_index{|y, x| y <=> x}.to_a)
	end
	def test_each_with_object_block
		items = Triple.new(1, 2, 3) 
		#assert_equal([], items.each_with_object([]){|y, x| y = x*2}.to_a)
	end
	def test_entries
		items = Triple.new(1, 2, 3) 
		assert_equal([1,2,3], items.to_a)
	end
	def test_find
		items = Triple.new(1, 2, 3) 
		assert_equal(3, items.find{|x| x==3})
	end
	def test_find_noItem
		items = Triple.new(1, 2, 3) 
		assert_equal(0, items.find(lambda {0}){|x| x < 1})
	end
	def test_find_none
		items = Triple.new(1, 2, 3) 
		assert_equal(nil, items.find{|x| x == 6})
	end
	def test_findAll_greaterthan2
		items = Triple.new(1, 2, 3) 
		assert_equal(3, items.find{|x| x > 2})
	end
	def test_findAll_none
		items = Triple.new(1, 2, 3) 
		assert_equal(nil, items.find{|x| x > 4})
	end
	def test_find_index
		items = Triple.new(1, 2, 3) 
		assert_equal(2, items.find_index(3))
	end
	def test_find_index_block
		items = Triple.new(1, 2, 3) 
		assert_equal(2, items.find_index{|x| x==3})
	end
	def test_find_index_none
		items = Triple.new(1, 2, 3) 
		assert_equal(nil, items.find_index(5))
	end
	def test_first
		items = Triple.new(1, 2, 3) 
		assert_equal(1, items.first)
	end
	def test_first_none
		items = Triple2.new() 
		#assert_equal(nil, items.first)
	end
	def test_first_n
		items = Triple.new(1, 2, 3) 
		assert_equal([1,2], items.first(2))
	end
	def test_flat_map_block
		items = Triple.new(1, 2, 3) 
		assert_equal([2,4,6], items.flat_map{|x| x*2})
	end
	def test_flat_map_none
		items = Triple2.new() 
		#assert_equal([], items.flat_map{|x| x*2})
	end
	def test_grep
		items = Triple.new(1, 2, 3) 
		assert_equal([2,3], items.grep(2..3))
	end
	def test_grep_block
		items = Triple.new(1, 2, 3) 
		assert_equal([4,6], items.grep(2..3){|x| x*2})
	end
	def test_grep_none
		items = Triple.new(1, 2, 3) 
		assert_equal([], items.grep(5..10))
	end
	def test_grep_v
		items = Triple.new(1, 2, 3) 
		assert_equal([1], items.grep_v(2..3))
	end
	def test_grep_v_block
		items = Triple.new(1, 2, 3) 
		assert_equal([2], items.grep_v(2..3){|x| x*2})
	end
	def test_grep_v_none
		items = Triple.new(1, 2, 3) 
		assert_equal([], items.grep_v(1..3))
	end
	def test_group_by_block
		items = Triple.new(1, 2, 3) 
		assert_equal({false=>[1,2,],true=>[3]}, items.group_by{|x| x>2})
	end
	def test_include
		items = Triple.new(1, 2, 3) 
		assert_equal(true, items.include?(2))
		assert_equal(false, items.include?(5))
	end
	def test_inject_initial_sym
		items = Triple.new(1, 2, 3) 
		assert_equal(6, items.inject{|y, x| y + x})
	end
	def test_inject_sym
		items = Triple.new(1, 2, 3) 
		assert_equal(8, items.inject(2){|y, x| y + x})
	end
	def test_inject_initial_memo
		items = Triple.new(1, 2, 3) 
		assert_equal(3, items.inject do |memo, x| memo>x ? memo:x end)
	end
	def test_inject_memo
		items = Triple.new(1, 2, 3) 
		#assert_equal(2, items.inject(2) do |memo, x| x>2 ? memo+x : )
	end
	def test_map
		items = Triple.new(1, 2, 3) 
		assert_equal([2,4,6], items.map{|x| x*2})
	end
	def test_max
		items = Triple.new(1, 2, 3) 
		assert_equal(3, items.max)
	end
	def test_max_block
		items = Triple.new("hello", "hi", "ciao") 
		assert_equal("hello", items.max{|y, x| y.length <=> x.length})
	end
	def test_max_n
		items = Triple.new(1, 2, 3) 
		assert_equal([3, 2], items.max(2))
	end
	def test_max_n_block
		items = Triple.new("hello", "hi", "ciao") 
		assert_equal(["hello", "ciao"], items.max(2){|y, x| y.length <=> x.length})
	end
	def test_max_by
		items = Triple.new("hello", "hi", "ciao") 
		assert_equal("hello", items.max_by{|x| x.length})
	end
	def test_max_by_n
		items = Triple.new("hello", "hi", "ciao") 
		assert_equal(["hello", "ciao"], items.max_by(2){|x| x.length})
	end
	def test_max_none
		items = Triple2.new() 
		#assert_equal(nil, items.max)
	end
	def test_member
		items = Triple.new(1, 2, 3) 
		assert_equal(true, items.member?(1))
		assert_equal(false, items.member?(5))
	end
	def test_min
		items = Triple.new(1, 2, 3) 
		assert_equal(1, items.min)
	end
	def test_min_block
		items = Triple.new("hello", "hi", "ciao") 
		assert_equal("hi", items.min{|y, x| y.length <=> x.length})
	end
	def test_min_n
		items = Triple.new(1, 2, 3) 
		assert_equal([1, 2], items.min(2))
	end
	def test_min_n_block
		items = Triple.new("hello", "hi", "ciao") 
		assert_equal(["hi", "ciao"], items.min(2){|y, x| y.length <=> x.length})
	end
	def test_min_by
		items = Triple.new("hello", "hi", "ciao") 
		assert_equal("hi", items.min_by{|x| x.length})
	end
	def test_min_by_n
		items = Triple.new("hello", "hi", "ciao") 
		assert_equal(["hi", "ciao"], items.min_by(2){|x| x.length})
	end
	def test_min_none
		items = Triple2.new() 
		#assert_equal(nil, items.min)
	end
	def test_minmax
		items = Triple.new(1, 2, 3) 
		assert_equal([1, 3], items.minmax)
	end
	def test_minmax_block
		items = Triple.new(1, 2, 3) 
		assert_equal([3, 1], items.minmax{|y, x| x <=> y})
	end
	def test_minmax_by
		items = Triple.new("hello", "hi", "ciao") 
		assert_equal(["hi", "hello"], items.minmax_by{|x| x.length})
	end
	def test_none
		items = Triple.new(1, 2, 3) 
		assert_equal(true, items.none?{|x| x>5})
		assert_equal(false, items.none?{|x| x>2})
	end
	def test_none_none
		items = Triple2.new() 
		#assert_equal(true, items.none?{|x| x>5})
	end
	def test_one
		items = Triple.new(1, 2, 3) 
		assert_equal(false, items.one?{|x| x>5})
		assert_equal(true, items.one?{|x| x>2})
		assert_equal(false, items.one?{|x| x>=2})
	end
	def test_partition_block
		items = Triple.new(1, 2, 3) 
		assert_equal([[3],[1,2]], items.partition{|x| x>2})
	end
	def test_reduce
		items = Triple.new(1, 2, 3) 
		assert_equal(6, items.reduce(0){|y, x| y + x})
		assert_equal(6, items.reduce{|y, x| y + x})
	end
	def test_reduce_none
		items = Triple2.new() 
		assert_equal(10, items.reduce(10){|y, x| y + x}) 
	end
	def test_reduceParameter_opAdd
		items = Triple.new(1, 2, 3) 
		assert_equal(6, items.reduce(0, :+))
		assert_equal(6, items.reduce(:+))
	end
	def test_reduceParameter_opMul
		items = Triple.new(1, 2, 3) 
		assert_equal(6, items.reduce(1, :*))
	end
	def test_reject
		items = Triple.new(1, 2, 3) 
		assert_equal([1,2,3], items.reject{})
	end
	def test_reject_block
		items = Triple.new(1, 2, 3) 
		assert_equal([1,2], items.reject{|x| x>2})
	end
	def test_reverse_each
		items = Triple.new(1, 2, 3) 
		assert_equal([3,2,1], items.reverse_each.to_a)
	end
	def test_reverse_each_block
		items = Triple.new(1, 2, 3) 
		#assert_equal([3,2], items.reverse_each{|x| x>1})
	end
	def test_select
		items = Triple.new(1, 2, 3) 
		assert_equal([2,3], items.select{|x| x>1})
	end
	def test_select_none
		items = Triple.new(1, 2, 3) 
		assert_equal([], items.select{|x| x>5})
	end
	def test_slice_after_pattern
		items = Triple.new(1, 2, 3) 
		assert_equal([[1],[2],[3]], items.slice_after(Integer).to_a)
	end
	def test_slice_after
		items = Triple.new(1, 2, 3) 
		assert_equal([[1],[2],[3]], items.slice_after{|e| Integer === e}.to_a)
	end
	def test_slice_before_pattern
		items = Triple.new(1, 2, 3) 
		assert_equal([[1],[2],[3]], items.slice_before(Integer).to_a)
	end
	def test_slice_before
		items = Triple.new(1, 2, 3) 
		assert_equal([[1],[2],[3]], items.slice_before{|e| Integer === e}.to_a)
	end
	def test_sort
		items = Triple.new("hello", "hi", "ciao") 
		assert_equal(["ciao","hello","hi"], items.sort)
	end
	def test_sort_block
		items = Triple.new(3, 1, 2) 
		assert_equal([3,2,1], items.sort{|y, x| x <=> y})
	end
	def test_sort_none
		items = Triple2.new() 
		#assert_equal([], items.sort)
	end
	def test_sort_by
		items = Triple.new("hello", "hi", "ciao") 
		assert_equal(["hello","hi","ciao"], items.sort_by{})
	end
	def test_sort_by_block
		items = Triple.new("hello", "hi", "ciao") 
		assert_equal(["hi","ciao","hello"], items.sort_by{|x| x.length})
	end
	def test_sort_by_block_none
		items = Triple2.new() 
		#assert_equal([], items.sort_by{|x| x.length})
	end
	def test_sum
		items = Triple.new(1, 2, 3)
		assert_equal(6, items.sum)
	end
	def test_sum_block
		items = Triple.new(1, 2, 3)
		assert_equal(12, items.sum{|x| x*2})
	end
	def test_sum_none
		items = Triple2.new()
		#assert_equal(0, items.sum{|x| x*2})
	end
	def test_take_n
		items = Triple.new(1, 2, 3)
		assert_equal([1,2], items.take(2))
	end
	def test_take_more
		items = Triple.new(1, 2, 3)
		assert_equal([1,2,3], items.take(5))
	end
	def test_take_none
		items = Triple2.new()
		#assert_equal([], items.take(5))
	end
	def test_take_while_block
		items = Triple.new(1, 2, 3)
		assert_equal([1], items.take_while{|x| x<2})
	end
	def test_to_a
		items = Triple.new(1, 2, 3)
		assert_equal([1,2,3], items.to_a)
	end
	def test_to_a_none
		items = Triple2.new()
		#assert_equal([], items.to_a)
	end
	def test_to_h
		items = Triple.new(1, 2, 3)
		assert_equal({1=>0, 2=>1, 3=>2}, items.each_with_index.to_h)
	end
	def test_to_h_none
		items = Triple2.new()
		#assert_equal({}, items.to_h)
	end
	def test_uniq
		items = Triple.new(1, 2, 3)
		assert_equal([1,2,3], items.uniq)
		items = Triple.new(1, 2, 2)
		assert_equal([1,2], items.uniq)
	end
	def test_uniq_block
		items = Triple.new(1, 2, 3)
		assert_equal([1], items.uniq{|x|})
	end
	def test_uniq_none
		items = Triple2.new()
		#assert_equal([], items.uniq)
	end
	def test_zip
		items1 = Triple.new(1, 2, 3)
		items2 = Triple.new(3, 4, 5)
		assert_equal([[1,3],[2,4],[3,5]], items1.zip(items2))
	end
	def test_zip_multiple
		items1 = Triple.new(1, 2, 3)
		items2 = Triple.new(3, 4, 5)
		items3 = Triple.new(5, 6, 7)
		assert_equal([[1,3,5],[2,4,6],[3,5,7]], items1.zip(items2, items3))
	end
	def test_zip_none
		items1 = Triple2.new()
		items2 = Triple2.new()
		#assert_equal([], items1.zip(items2))
	end
	def test_zip_nil
		items1 = Triple.new(1, 2, 3)
		items2 = Triple.new(3, 4, 5)
		assert_equal(nil, items1.zip(items2){|y, x| y > x})
	end
end