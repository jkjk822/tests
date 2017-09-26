#!/usr/bin/env ruby

require 'minitest/autorun'

class TestEnum < MiniTest::Test

	def setup
		@triple_int = Triple.new(1, 2, 3)
		@triple_string = Triple.new('Apple', 'bee', 'Computer')
		@triple_duplicate = Triple.new(1, 2, 2)
		@triple_to_hash = Triple.new([1,'a'],[2,'b'],[3,'c'])
	end

	def test_all_happy_case
		assert_equal true, @triple_int.all? {|num| num <= 3}
	end 

	def test_all_happy_case_two
		assert_equal false, @triple_string.all? {|word| word.length < 5}
	end

	def test_any_happy_case
		assert_equal true, @triple_int.any? {|num| num == 2}
	end

	def test_any_happy_case
		assert_equal false, @triple_string.any? {|word| word == 'fly'}
	end

	def test_chunk_happy_case
		resultArray = []
		@triple_int.chunk {|num| num > 1}.each {|bool, array| resultArray << [bool, array]}
		assert_equal [[false, [1]], [true, [2, 3]]], resultArray
	end

	def test_chunk_happy_case_two
		resultArray = []
		@triple_string.chunk {|word| word == 'bee'}. each {|bool, array| resultArray << [bool, array]}
		assert_equal [[false, ['Apple']], [true, ['bee']], [false, ['Computer']]], resultArray
	end

	def test_chunk_while_happy_case
		resultArray = []
		@triple_int.chunk_while {|i, j| (i+j) * 2 < 7}.each {|array| resultArray << array}
		assert_equal [[1, 2], [3]], resultArray
	end

	def test_chunk_while_happy_case_two
		resultArray = []
		@triple_int.chunk_while {|i, j| (i+j) < 1}.each {|array| resultArray << array}
		assert_equal [[1], [2], [3]], resultArray
	end

	def test_collect_happy_case
		assert_equal [2, 4, 6], @triple_int.collect {|num| num * 2}
	end

	def test_collect_happy_case_two
		assert_equal ['Appleone', 'beeone', 'Computerone'], @triple_string.collect {|word| word + 'one'}
	end

	def test_collect_concat_happy_case
		assert_equal [2 , 4 , 6] , @triple_int.collect_concat {|num| num * 2}
	end

	def test_collect_concat_happy_case_two
		assert_equal [1, 'a', 4, 2, 'b', 4, 3, 'c', 4], @triple_to_hash.collect_concat {|item| item + [4]}
	end

	def test_count_happy_case
		assert_equal 3, @triple_int.count
	end

	def test_count_happy_case_two
		assert_equal 3, @triple_to_hash.count
	end

	def test_count_paren_happy_case
		assert_equal 1, @triple_int.count(1)
	end

	def test_count_paren_happy_case_two
		assert_equal 2, @triple_duplicate.count(2)
	end

	def test_count_block_happy_case
		assert_equal 2, @triple_int.count {|num| num > 1}
	end

	def test_count_block_happy_case_two
		assert_equal 2, @triple_string.count {|word| word.length < 6}
	end

	def test_cycle_happy_case
		resultArray = []
		@triple_string.cycle(4) {|word| resultArray << word.length}
		assert_equal [5, 3, 8, 5, 3, 8, 5, 3, 8, 5, 3, 8], resultArray
	end

	def test_cycle_happy_case_two
		resultArray = []
		@triple_string.cycle(0) {|word| resultArray << word.length}
		assert_equal [], resultArray
	end

	def test_detect_happy_case
		assert_nil @triple_string.detect {|word| word == 'hello'}
	end

	def test_detect_happy_case_two
		assert_equal 'bee', @triple_string.detect {|word| word == 'bee'}
	end

	def test_drop_happy_case
		assert_equal [] , @triple_int.drop(3)
	end

	def test_drop_happy_case_two
		assert_equal [3], @triple_int.drop(2)
	end

	def test_drop_happy_case_three
		assert_equal [1, 2, 3], @triple_int.drop(0)	
	end	

	def test_drop_while_happy_case
		assert_equal ['bee', 'Computer'], @triple_string.drop_while {|word| word == 'Apple'}
	end

	def test_drop_while_happy_case_two
		assert_equal [], @triple_string.drop_while {|word| word != 'hello'}
	end

	def test_each_cons_happy_case
		resultArray = []
		@triple_int.each_cons(2) {|array| resultArray << array}
		assert_equal [[1, 2], [2, 3]], resultArray
	end

	def test_each_cons_happy_case_two
		resultArray = []
		@triple_to_hash.each_cons(2) {|array| resultArray << array}
		assert_equal [[[1, 'a'], [2, 'b']], [[2, 'b'], [3, 'c']]], resultArray
	end

	def test_each_entry_happy_case
		resultArray = []
		@triple_int.each_entry {|num| resultArray << num * 2}
		assert_equal [2, 4, 6], resultArray
	end

	def test_each_entry_happy_case_two
		resultArray = []
		@triple_string.each_entry {|word| resultArray << word + 'one'}
		assert_equal ['Appleone', 'beeone', 'Computerone'], resultArray
	end

	def test_each_slice_happy_case
		resultArray = []
		@triple_string.each_slice(2) {|array| resultArray << array}
		assert_equal [['Apple', 'bee'], ['Computer']], resultArray
	end

	def test_each_with_index_happy_case
		resultArray = []
		@triple_string.each_with_index {|word, ind| resultArray << [ind, word]}
		assert_equal [[0, 'Apple'],[1, 'bee'],[2, 'Computer']], resultArray
	end

	def test_each_with_index_happy_case_two
		resultArray = []
		@triple_int.each_with_index {|num, ind| resultArray << [ind, num + 10]}
		assert_equal [[0, 11],[1, 12],[2, 13]], resultArray
	end

	def test_each_with_object_happy_case
		assert_equal ['hello', 'Apple', 'bee', 'Computer'], @triple_string.each_with_object(["hello"]) {|word, a| a << word }
	end
	
	def test_entries_happy_case
		assert_equal [1, 2, 3], @triple_int.entries
	end

	def test_find_happy_case
		assert_nil @triple_string.find {|word| word == 'hello'}
	end

	def test_find_happy_case_two
		assert_equal 'bee', @triple_string.find {|word| word == 'bee'}
	end

	def test_find_all_happy_case
		assert_equal [1, 2], @triple_int.find_all {|num| num < 3}
	end

	def test_find_all_happy_case_two
		assert_equal [], @triple_int.find_all {|num| num > 8}
	end

	def test_find_index_value_happy_case
		assert_equal 2, @triple_int.find_index(3)
	end
	
	def test_find_index_value_happy_case_two
		assert_nil @triple_string.find_index('A')
	end

	def test_find_index_block_happy_case
		assert_equal 1, @triple_int.find_index {|num| num > 1}
	end

	def test_first_happy_case
		assert_equal 'Apple', @triple_string.first
	end

	def test_first_happy_case_two
		assert_equal [1, 'a'], @triple_to_hash.first
	end

	def test_first_var_happy_case
		assert_equal ['Apple', 'bee'], @triple_string.first(2)
	end

	def test_flat_map_happy_case
		assert_equal [2, 4, 6], @triple_int.collect {|num| num * 2}
	end

	def test_grep_happy_case
		assert_equal [1, 2], @triple_int.grep(1..2)
	end

	def test_grep_block_happy_case
		assert_equal [true, false], @triple_int.grep(1..2) {|num| num%2 == 1}
	end

	def test_grep_v_happy_case
		assert_equal [3], @triple_int.grep_v(1..2)
	end
	
	def test_grep_v_happy_case_two
		assert_equal [], @triple_int.grep_v(1..3)
	end
	
	def test_grep_v_block_happy_case
		assert_equal [true], @triple_int.grep_v(1..2) {|num| num%2 == 1}
	end
	
	def test_group_by_happy_case
		expected_hash = { true => [1,3], false => [2]}
		assert_equal expected_hash, @triple_int.group_by {|num| num%2==1}
	end
	
	def test_include_happy_case
		assert @triple_int.include?(2)
	end

	def test_include_happy_case_two
		assert_equal false, @triple_int.include?(4)
	end

	def test_inject_init_sym_happy_case
		assert_equal 12, @triple_int.inject(2, :*)
	end

	def test_inject_init_sym_happy_case_two
		assert_equal 'helloApplebeeComputer', @triple_string.inject('hello', :+)
	end

	def test_inject_sym_happy_case
		assert_equal 6, @triple_int.inject(:*)
	end

	def test_inject_sym_happy_case_two
		assert_equal 'ApplebeeComputer', @triple_string.inject(:+)
	end

	def test_inject_init_block_happy_case
		assert_equal 12, @triple_int.inject(2) {|init, num| init * num}
	end

	def test_inject_block_happy_case
		assert_equal 6, @triple_int.inject {|init, num| init * num}
	end

	def test_map_happy_case
		assert_equal [2, 4, 6], @triple_int.map {|num| num * 2}
	end

	def test_max_happy_case
		assert_equal 'bee', @triple_string.max
	end

	def test_max_happy_case_two
		assert_equal 3, @triple_int.max
	end

	def test_max_block_happy_case
		assert_equal 'bee', @triple_string.max {|x, y| x[0] <=> y[0]}
	end
	
	def test_max_n_happy_case
		assert_equal [3, 2], @triple_int.max(2)
	end

	def test_max_n_happy_case_two
		assert_equal [], @triple_int.max(0)
	end

	def test_max_n_happy_case_three
		assert_equal [3, 2, 1], @triple_int.max(5)
	end

	def test_max_n_block_happy_case
		assert_equal ['bee', 'Computer'], @triple_string.max(2) {|x, y| x[0] <=> y[0]}
	end

	def test_max_by_happy_case
		assert_equal 'Apple', @triple_string.max_by {|word| word[1]}
	end

	def test_max_by_n_happy_case
		assert_equal ['Apple', 'Computer'], @triple_string.max_by(2) {|word| word[1]}
	end

	def test_member_happy_case
		assert @triple_string.member?('Apple')
	end

	def test_member_happy_cacse
		assert_equal false, @triple_string.member?('apple')
	end

	def test_min_happy_case
		assert_equal 'Apple', @triple_string.min
	end

	def test_min_happy_case_two
		assert_equal 1, @triple_int.min
	end

	def test_min_block_happy_case
		assert_equal 'Apple', @triple_string.min {|x, y| x[0] <=> y[0]}
	end

	def test_min_n_happy_case
		assert_equal [1, 2], @triple_int.min(2)
	end

	def test_min_n_block_happy_case
		assert_equal ['Apple', 'Computer'], @triple_string.min(2) {|x, y| x[0] <=> y[0]}
	end

	def test_min_by_happy_case
		assert_equal 'Apple', @triple_string.min_by {|word| word[0]}
	end

	def test_min_by_n_happy_case
		assert_equal ['bee', 'Computer'], @triple_string.min_by(2) {|word| word[1]}
	end

	def test_minmax_happy_case
		assert_equal [1, 3], @triple_int.minmax
	end

	def test_minmax_block_happy_case
		assert_equal ['Apple', 'bee'], @triple_string.minmax {|x, y| x[0] <=> y[0]}
	end

	def test_minmax_by_happy_case
		assert_equal ['bee', 'Apple'], @triple_string.minmax_by {|word| word[1]}
	end

	def test_none_happy_case
		assert @triple_int.none? {|num| num > 5}
	end

	def test_one_happy_case
		assert @triple_int.one? {|num| num%2 == 0}
	end

	def test_partition_happy_case
		assert_equal [[1, 3], [2]], @triple_int.partition {|num| num%2 == 1}
	end

	def test_reduce_init_sym_happy_case
		assert_equal 12, @triple_int.reduce(2, :*)
        end

        def test_reduce_sym_happy_case
                assert_equal 6, @triple_int.reduce(:*)
        end

        def test_reduce_init_block_happy_case
                assert_equal 12, @triple_int.reduce(2) {|init, num| init * num}
        end

        def test_reduce_block_happy_case
                assert_equal 6, @triple_int.reduce {|init, num| init * num}
        end
	
	def test_reject_happy_test
		assert_equal [1, 3], @triple_int.reject {|num| num % 2 == 0}
	end

	def test_reverse_each_happy_case
		resultArray = []
		@triple_int.reverse_each {|num| resultArray << num}
		assert_equal [3, 2, 1], resultArray
	end
	
	def test_select_happy_case
		assert_equal [1, 3], @triple_int.select {|num| num % 2 == 1}
	end

	def test_slice_after_happy_case
		resultArray = []
		@triple_int.slice_after(2).each {|array| resultArray << array}
		assert_equal [[1, 2], [3]], resultArray
	end

	def test_slice_after_bool_happy_case
		resultArray = []
		@triple_int.slice_after {|num| num % 2 == 0}.each {|array| resultArray << array}
		assert_equal [[1, 2], [3]], resultArray
	end

	def test_slice_before_happy_case
                resultArray = []
                @triple_int.slice_before(2).each {|array| resultArray << array}
                assert_equal [[1], [2, 3]], resultArray
        end

        def test_slice_after_bool_happy_case
                resultArray = []
                @triple_int.slice_before {|num| num % 2 == 0}.each {|array| resultArray << array}
                assert_equal [[1], [2, 3]], resultArray
        end
	
	def test_slice_when_happy_case
		resultArray = []
		@triple_int.slice_when {|x, y| y - x == 1}.each {|array| resultArray << array}
		assert_equal [[1], [2], [3]], resultArray
	end
	
	def test_sort_happy_case
		assert_equal ['Apple', 'Computer', 'bee'], @triple_string.sort {|x, y| x[0] <=> y[0]}
	end

	def test_sort_by_happy_case
		assert_equal ['bee', 'Computer', 'Apple'], @triple_string.sort_by {|word| word[1]}
	end

	def test_sum_happy_case
		assert_equal 6, @triple_int.sum
	end

	def test_sum_block_happy_case
		assert_equal 12, @triple_int.sum {|num| num * 2}
	end

	def test_take_happy_case
		assert_equal [1, 2], @triple_int.take(2)
	end

	def test_take_while_happy_case
		assert_equal [1, 2], @triple_int.take_while {|num| num < 3}
	end

	def test_to_a_happy_case
		assert_equal [1, 2, 3], @triple_int.to_a
	end

	def test_to_h_happy_case
		expected_hash = {1 => 'a', 2 => 'b', 3 =>'c'}
		assert_equal expected_hash, @triple_to_hash.to_h
	end

	def test_uniq_happy_case
		assert_equal [1, 2], @triple_duplicate.uniq
	end

	def test_uniq_happy_case_two
		assert_equal [1, 2], @triple_int.uniq {|num| num%2}
	end

	def test_zip_happy_case
		assert_equal [[1, 'Apple'], [2, 'bee'], [3, 'Computer']], @triple_int.zip(@triple_string)
	end
	
	def test_zip_block_happy_case
		result_array = []
		@triple_int.zip(@triple_string) {|array| result_array << array}
		 assert_equal [[1, 'Apple'], [2, 'bee'], [3, 'Computer']], result_array
	end
	
	def test_zip_block_happy_case_two
		result_array = []
		@triple_int.zip(@triple_int) {|x,y| result_array << x+y}
		assert_equal [2, 4, 6], result_array
	end	
end
