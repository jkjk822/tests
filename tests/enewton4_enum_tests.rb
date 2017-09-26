#!/usr/bin/env ruby

require 'minitest/autorun'

# Unit Tests for Enumerable Class
class ENewton4Tests < Minitest::Test

    # Setup
    def setup
        @norm_int_enum = Triple.new(1, 2, 3)
        @norm_string_enum = Triple.new("Hello", "World", "!")
        @norm_mix_enum = Triple.new(1, "World", 3)
        @uniq_int_enum = Triple.new(1, 1, 1)
        @hash_int_enum = Triple.new([1, "what"], [2, "the"], [3, ""])
    end

    # - all?
    # NOTE: Apparently naming thing 'test_all?_success'
    #       causes problems with calling the funciton.
    def test_all_success
        assert @norm_int_enum.all? { |a| a >= 1 }
        assert @norm_string_enum.all? { |a| a.length * 3 > 2}
        assert @norm_mix_enum.all? { |a| a != 2 }

        refute @norm_int_enum.all? { |a| a == 1}
        refute @norm_string_enum.all? { |a| a == "Hello"}
        refute @norm_mix_enum.all? { |a| a + a != 6 }
    end

    # - any?
    def test_any_success
        assert @norm_int_enum.any? { |a| a == 1 } 
        assert @norm_string_enum.any? { |a| a. == "!" } 
        assert @norm_mix_enum.any? { |a| a + a == 2 } 

        refute @norm_int_enum.any? { |a| a == 4 }
        refute @norm_string_enum.any? { |a| a.empty? } 
        refute @norm_mix_enum.any? { |a| a == 2 } 
    end

    # - chunck
    def test_chunk_success
        ## Int
        result = @norm_int_enum.chunk { |a| a.even? }

        arr = []
        result.each { |a| arr << a }

        assert_equal [[false, [1]], [true, [2]], [false, [3]]], arr

        ## String
        result = @norm_string_enum.chunk { |a| a.end_with? "?" }

        arr = []
        result.each { |a| arr << a }

        assert_equal [[false, ["Hello", "World", "!"]]], arr

        ## Mix
        result = @norm_mix_enum.chunk { |a| a != 2 }

        arr = []
        result.each { |a| arr << a }

        assert_equal [[true, [1, "World", 3]]], arr
    end

    def test_chunk_while_success
        ## Int
        result = @norm_int_enum.chunk_while { |a, b| a == b }

        arr = []
        result.each { |a| arr << a }

        assert_equal [[1], [2], [3]], arr

        ## String
        result = @norm_string_enum.chunk_while { |a, b| a < b }

        arr = []
        result.each { |a| arr << a }

        assert_equal [["Hello", "World"], ["!"]], arr

        ## Mix
        result = @norm_mix_enum.chunk_while { |a, b| a != b }

        arr = []
        result.each { |a| arr << a }

        assert_equal [[1, "World", 3]], arr
    end

    def test_collect_success
        assert_equal [2, 4, 6], @norm_int_enum.collect { |a| a * 2 }
        assert_equal ["Hello!?", "World!?", "!!?"], @norm_string_enum.collect { |a| a << "!?" }
        assert_equal ["1", "World", "3"], @norm_mix_enum.collect { |a| a.to_s }

        refute_equal [1, 2, 2, 4, 3, 6], @norm_int_enum.collect { |a| [a, a*2] }
    end

    def test_collect_concat_success
        assert_equal [1, 2, 2, 4, 3, 6], @norm_int_enum.collect_concat { |a| [a, a*2] }
        assert_equal ["Hello", "!", "World", "!", "!", "!"], @norm_string_enum.collect_concat { |a| [a, "!"] }
        assert_equal [1, 0, "World", "", 3, 0], @norm_mix_enum.collect_concat { |a| [a, a*0] }
    end

    def test_count_success
        # count
        assert_equal 3, @norm_int_enum.count
        assert_equal 3, @norm_string_enum.count
        assert_equal 3, @norm_mix_enum.count

        # count(n)
        assert_equal 1, @norm_int_enum.count(1)
        assert_equal 0, @norm_string_enum.count(1)
        assert_equal 1, @norm_mix_enum.count(3)

        # count { |obj| ... }
        assert_equal 2, @norm_int_enum.count { |a| a % 2 == 1 }
        assert_equal 2, @norm_string_enum.count { |a| a.length == 5 }
        assert_equal 1, @norm_mix_enum.count { |a| a * 2 == "WorldWorld" }
    end

    # def test_cycle_success
    #     # Test change to orig var
    #     arr = @norm_int_enum.cycle(2)

    #     assert_equal [1, 2, 3, 1, 2, 3], arr
    # end

    def test_detect_success
        # Test Args
        assert_nil @norm_int_enum.detect { |a| a == 0 }
        assert_equal "!", @norm_string_enum.detect { |a| a.length < 3 }
    end

    def test_drop_success
        assert_equal [2, 3], @norm_int_enum.drop(1)
        assert_equal [3], @norm_int_enum.drop(2)
        assert_equal [], @norm_int_enum.drop(3)
        # Dropping more just does nothing 
        assert_equal [], @norm_int_enum.drop(4)
    end

    def test_drop_while_success
        assert_equal [3], @norm_int_enum.drop_while { |a| a < 3 }
        assert_equal ["!"], @norm_string_enum.drop_while { |a| a.length > 1 }
        assert_equal [1, "World", 3], @norm_mix_enum.drop_while { |a| a != 1 }
    end

    def test_each_cons_success
        result = @norm_int_enum.each_cons(2)

        arr = []
        result.each { |a| arr << a }

        assert_equal [[1, 2], [2, 3]], arr
    end

    def test_each_entry_success
        arr = []
        @norm_int_enum.each_entry { |a| arr << a }
        assert_equal [1, 2, 3], arr

    end

    def test_each_slice_success
        arr = []
        @norm_int_enum.each_slice(2) { |a| arr << a }
        assert_equal [[1, 2], [3]], arr

        arr = []
        @norm_int_enum.each_slice(1) { |a| arr << a }
        assert_equal [[1], [2], [3]], arr
    end

    def test_each_with_index_success
        arr = []
        @norm_mix_enum.each_with_index { |a, i| arr << [i, a] }
        assert_equal [[0, 1], [1, "World"], [2, 3]], arr
    end

    def test_each_with_object_success
        h = @norm_mix_enum.each_with_object(Hash.new) { |a, b| b[a] = a }
        assert_equal Hash[1 => 1, "World" => "World", 3 => 3], h
    end

    def test_entries_success
        assert_equal [1, 2, 3], @norm_int_enum.entries
        assert_equal ["Hello", "World", "!"], @norm_string_enum.entries
        assert_equal [1, "World", 3], @norm_mix_enum.entries
    end

    def test_find_success
        # Test Args
        assert_nil @norm_int_enum.find { |a| a == 0 }
        assert_equal "!", @norm_string_enum.find { |a| a.length < 3 }
    end

    def test_find_all_success
        assert_equal [2, 3], @norm_int_enum.find_all { |a| a > 1 }
        assert_empty @norm_string_enum.find_all { |a| a.length > 10 }
    end

    def test_find_index_success
        assert_nil @norm_int_enum.find_index { |a| a > 3 }
        assert_equal 2, @norm_int_enum.find_index { |a| a > 2 }

        assert_equal 0, @norm_string_enum.find_index { |a| a.length == 5 }

        assert_equal 1, @norm_string_enum.find_index("World")
    end

    def test_first_success
        assert_equal [], @norm_int_enum.first(0)
        assert_equal [1], @norm_int_enum.first(1)
        assert_equal [1, 2], @norm_int_enum.first(2)
        assert_equal [1, 2, 3], @norm_int_enum.first(3)

        assert_equal 1, @norm_int_enum.first
    end

    def test_flat_map_success
        # NOTE: Same as collect_concat
        assert_equal [1, 2, 2, 4, 3, 6], @norm_int_enum.flat_map { |a| [a, a*2] }
        assert_equal ["Hello", "!", "World", "!", "!", "!"], @norm_string_enum.flat_map { |a| [a, "!"] }
        assert_equal [1, 0, "World", "", 3, 0], @norm_mix_enum.flat_map { |a| [a, a*0] }
    end

    def test_grep_success
        assert_equal [1, 2], @norm_int_enum.grep(1..2)
        assert_equal ["Hello", "!"], @norm_string_enum.grep(/Hello|!/)
        assert_equal ["World"], @norm_mix_enum.grep(String)

        assert_equal [true, false], @norm_int_enum.grep(1..2) { |a| a < 2 }
    end


    def test_grep_v_success
        assert_equal [3], @norm_int_enum.grep_v(1..2)
        assert_equal ["World"], @norm_string_enum.grep_v(/Hello|!/)
        assert_equal [1, 3], @norm_mix_enum.grep_v(String)

        assert_equal [false], @norm_int_enum.grep_v(1..2) { |a| a < 2 }

    end

    def test_group_by_success
        assert_equal Hash[1 => [1], 2 => [2], 3 => [3]], @norm_int_enum.group_by { |a| a }
    end

    def test_group_by_failure
        assert_raises(NoMethodError) { @norm_int_enum.group_by { |a| a.length } }
    end

    def test_include_success
        assert @norm_int_enum.include? 1
        assert @norm_int_enum.include? 3

        refute @norm_int_enum.include? 0
        refute @norm_int_enum.include? 4
    end

    def test_inject_success
        # NOTE: Same as 'reduce'
        assert_equal 6, @norm_int_enum.inject(:+)
        assert_equal 8, @norm_int_enum.inject(2, :+)
        assert_equal 11, @norm_int_enum.inject { |s, a| s + a*2 }
        # what....
        assert_equal 12, @norm_int_enum.inject(0) { |s, a| s + a*2 }
    end

    def test_inject_failure
        assert_raises(NoMethodError) { @norm_int_enum.inject { |s, a| s + a.length } }
    end

    def test_map_success
        # NOTE: Same as 'collect'
        assert_equal [2, 4, 6], @norm_int_enum.map { |a| a * 2 }
        assert_equal ["Hello!?", "World!?", "!!?"], @norm_string_enum.map { |a| a << "!?" }
        assert_equal ["1", "World", "3"], @norm_mix_enum.map { |a| a.to_s }

        refute_equal [1, 2, 2, 4, 3, 6], @norm_int_enum.map { |a| [a, a*2] }
    end

    def test_map_failure
        assert_raises(NoMethodError) { @norm_int_enum.map { |a| a.length } }
    end

    def test_max_success
        assert_equal 3, @norm_int_enum.max
        assert_equal "World", @norm_string_enum.max

        assert_equal [3, 2], @norm_int_enum.max(2)

        assert_equal 3, @norm_int_enum.max { |a, b| a <=> b }
    end

    def test_max_failure
        assert_raises(ArgumentError) { @norm_mix_enum.max }
    end

    def test_max_by_success
        assert_equal 1, @norm_int_enum.max_by { |a| 3 - a } 
        assert_equal [1, 2], @norm_int_enum.max_by(2) { |a| 3 - a }
    end

    def test_max_by_failure
        assert_raises(NoMethodError) { @norm_int_enum.max_by { |a| a.length } }
    end

    def test_member_success
        # NOTE: Same as 'include?'
        assert @norm_int_enum.member? 1
        assert @norm_int_enum.member? 3

        refute @norm_int_enum.member? 0
        refute @norm_int_enum.member? 4
    end

    def test_min_success
        assert_equal 1, @norm_int_enum.min
        assert_equal [1, 2], @norm_int_enum.min(2)
        assert_equal 1, @norm_int_enum.min { |a, b| a <=> b }
        assert_equal [1, 2], @norm_int_enum.min(2) { |a, b| a <=> b }
    end

    def test_min_by_success
        assert_equal 3, @norm_int_enum.min_by { |a| 3 - a } 
        assert_equal [3, 2], @norm_int_enum.min_by(2) { |a| 3 - a }
    end

    def test_min_by_failure
        assert_raises(NoMethodError) { @norm_int_enum.min_by { |a| a.length } }
    end

    def test_minmax_success
        assert_equal [1, 3], @norm_int_enum.minmax
        assert_equal [1, 3], @norm_int_enum.minmax { |a, b| a <=> b }
    end

    def test_minmax_by_success
        assert_equal [1, 3], @norm_int_enum.minmax_by { |a| a }
    end

    def test_minmax_by_failure
        assert_raises(NoMethodError) { @norm_int_enum.minmax_by { |a| a.length } }
    end

    def test_none_success
        assert @norm_int_enum.none? { |a| a == 4}
        assert @norm_string_enum.none? { |a| a.length == 4}

        refute @norm_string_enum.none? { |a| a.length == 1}
    end

    def test_none_failure
        assert_raises(NoMethodError) { @norm_int_enum.none? { |a| a.length } }
    end

    def test_one_success
        assert @norm_int_enum.one? { |a| a == 2 }

        refute @norm_string_enum.one? { |a| a.length == 5 }
    end

    def test_one_failure
        assert_raises(NoMethodError) { @norm_int_enum.one? { |a| a.length } }
    end

    def test_partition_success
        assert_equal [[1], [2, 3]], @norm_int_enum.partition { |a| a == 1 }
    end

    def test_partition_failure
        assert_raises(NoMethodError) { @norm_int_enum.partition { |a| a.length } }
    end

    def test_reduce_success
        # NOTE: Same as 'inject'
        assert_equal 6, @norm_int_enum.reduce(:+)
        assert_equal 8, @norm_int_enum.reduce(2, :+)
        assert_equal 11, @norm_int_enum.reduce { |s, a| s + a*2 }
        # what....
        assert_equal 12, @norm_int_enum.reduce(0) { |s, a| s + a*2 }
    end

    def test_reduce_failure
        assert_raises(NoMethodError) { @norm_int_enum.reduce { |s, a| s + a.length } }
    end

    def test_reject_success
        assert_equal [1], @norm_int_enum.reject { |a| a > 1 }
        assert_equal [2, 3], @norm_int_enum.reject { |a| a < 2 }
    end

    def test_reject_failure
        assert_raises(NoMethodError) { @norm_int_enum.reject { |a| a.length } }
    end

    def test_reverse_each_success
        arr = []
        @norm_int_enum.reverse_each { |a| arr << a }
        assert_equal [3, 2, 1], arr
    end

    def test_reverse_each_failure
        arr = []
        assert_raises(NoMethodError) { @norm_int_enum.reverse_each { |a| arr << a.length } }
    end

    def test_select_success
        # NOTE: Same as find_all
        assert_equal [2, 3], @norm_int_enum.select { |a| a > 1 }
        assert_empty @norm_string_enum.select { |a| a.length > 10 }
    end

    def test_slice_after_success
        arr = []
        @norm_int_enum.slice_after(Integer).each { |a| arr << a }
        assert_equal [[1], [2], [3]], arr

        arr = []
        @norm_string_enum.slice_after { |a| a.length == 5 }.each { |a| arr << a }
        assert_equal [["Hello"], ["World"], ["!"]], arr
    end

    def test_slice_after_failure
        arr = []

        assert_raises(NoMethodError) { 
            @norm_mix_enum.slice_after { |a| a.length == 5 }.each { |a| arr << a } 
        }
    end

    def test_slice_before_success
        arr = []
        @norm_int_enum.slice_before(Integer).each { |a| arr << a }
        assert_equal [[1], [2], [3]], arr

        arr = []
        @norm_string_enum.slice_before { |a| a.length == 5 }.each { |a| arr << a }
        assert_equal [["Hello"], ["World", "!"]], arr
    end

    def test_slice_before_failure
        arr = []

        assert_raises(NoMethodError) { 
            @norm_mix_enum.slice_before { |a| a.length == 5 }.each { |a| arr << a } 
        }
    end

    def test_slice_when_success
        arr = []
        @norm_int_enum.slice_when { |a, b| a < b }.each { |a| arr << a }
        assert_equal [[1], [2], [3]], arr
    end

    def test_slice_when_failure
        arr = []
        assert_raises(NoMethodError) { 
            @norm_mix_enum.slice_when { |a, b| a.length > b.length }.each { |a| arr << a } 
        }
    end

    def test_sort_success
        assert_equal ["!", "Hello", "World"], @norm_string_enum.sort { |a, b| a <=> b }
    end

    def test_sort_by_success
        assert_equal [3, 2, 1], @norm_int_enum.sort_by { |a| 3 - a }
    end

    def test_sort_by_failure
        assert_raises(NoMethodError) { @norm_mix_enum.sort_by { |a| a.length } }
    end

    def test_sum_success
        assert_equal 6, @norm_int_enum.sum(0)
        assert_equal 8, @norm_int_enum.sum(2)
    end

    def test_sum_failure
        assert_raises(TypeError) { @norm_mix_enum.sum }
    end

    def test_take_success
        assert_equal [1], @norm_int_enum.take(1)
        assert_equal [1, 2], @norm_int_enum.take(2)
        assert_equal [1, 2, 3], @norm_int_enum.take(3)
        assert_equal [1, 2, 3], @norm_int_enum.take(4)
    end

    def test_take_failure
        assert_raises(ArgumentError) { @norm_int_enum.take(-1) }
    end

    def test_take_while_success
        assert_equal [1, 2], @norm_int_enum.take_while { |a| a < 3 }
    end

    def test_take_while_failured
        assert_raises(NoMethodError) { @norm_mix_enum.take_while { |a| a.length > 3 }}
    end

    def test_to_a_success
        # NOTE: Same as 'entries'
        assert_equal [1, 2, 3], @norm_int_enum.to_a
        assert_equal ["Hello", "World", "!"], @norm_string_enum.to_a
        assert_equal [1, "World", 3], @norm_mix_enum.to_a
    end

    def test_to_h_success
        assert_equal Hash[1 => "what", 2 => "the", 3 => ""], @hash_int_enum.to_h
    end

    def test_to_h_failure
        assert_raises(TypeError) { @norm_int_enum.to_h }
    end

    def test_uniq_success
        assert_equal [1], @uniq_int_enum.uniq

        assert_equal [1], @uniq_int_enum.uniq { |a| a }
    end

    def test_zip_success
        assert_equal [[1, "Hello"], [2, "World"], [3, "!"]], 
            @norm_int_enum.zip( @norm_string_enum )
    end
end
