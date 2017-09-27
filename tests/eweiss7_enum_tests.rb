require 'minitest/autorun'

class Eweiss7Test < Minitest::Test

    # Setup - create Triples to use in test cases

    def setup
        @triple = Triple.new(3,2,9)
        @triple_nil = Triple.new(nil, nil, nil)
        @triple_string = Triple.new("la", "di", "da")
        @triple_bool = Triple.new(false, true, true)
        @triple_mixed = Triple.new("test", 17, true)
    end


    # all?

    # Case where every result is true
    def test_all_allTrue
        assert @triple.all? { |e| e < 10 }
    end

    # Case where every result is false
    def test_all_allFalse
        assert !@triple.all? { |e| e > 10 }
    end

    # Case where there exists false results
    def test_all_someFalse
        assert !@triple.all? { |e| e > 3 }
    end

    # Case where nil values are stored in a triple
    # by definition of all, nil should produce false
    def test_all_nil
        assert !@triple_nil.all?
    end

    # Case where a false value is stored in a triple
    # by definition of all, false should produce false
    def test_all_withFalse
        assert !@triple_bool.all?
    end


    # any?

    # Case where every result is true
    def test_any_allTrue
        assert @triple.any? { |e| e < 10 }
    end

    # Case where every result is false
    def test_any_allFalse
        assert !@triple.any? { |e| e > 10 }
    end

    # Case where there exists false results
    def test_any_someFalse
        assert @triple.any? { |e| e > 3 }
    end

    # Case where nil values are stored in a triple
    # by definition of any, nil should produce false
    def test_any_nil
        assert !@triple_nil.any?
    end

    # Case where a false value is stored in a triple
    # Should return true since ther is a true in the triple
    def test_any_withFalse
        assert @triple_bool.any?
    end


    # chunk

    # Case where all values match
    # chunk based on % 1 == 0, convert Enumerable to array, and check result
    def test_chunk_allMatch
        assert_equal [[true, [3, 2, 9]]], @triple.chunk { |e| e % 1 == 0 }.to_a
    end

    # Case where no values match
    # chunk based on % 4 == 0, convert Enumerable to array, and check result
    def test_chunk_noneMatch
        assert_equal [[false, [3, 2, 9]]], @triple.chunk { |e| e % 4 == 0 }.to_a
    end

    # Case where some values match
    # chunk based on % 3 == 0, convert Enumerable to array, and check result
    def test_chunk_someMatch
        assert_equal [[true, [3]], [false, [2]], [true, [9]]], @triple.chunk { |e| e % 3 == 0 }.to_a
    end

    # Case where all elements are ignored by separator
    def test_chunk_allIgnore
        assert_equal [], @triple.chunk { |e| :_separator }.to_a
    end

    # Case where all elements are nil
    def test_chunk_nil
        assert_equal [[false, [nil, nil, nil]]], @triple_nil.chunk { |e| e == 5 }.to_a
    end


    # chunk_while

    # Case where all values match
    def test_chunk_while_allMatch
        assert_equal [[3, 2, 9]], @triple.chunk_while { |e, f| e == e && f == f }.to_a
    end

    # Case where no values match
    def test_chunk_while_noneMatch
        assert_equal [[3], [2], [9]], @triple.chunk_while { |e, f| e == 5 }.to_a
    end

    # Case where some values match
    def test_chunk_while_someMatch
        assert_equal [[3, 2], [9]], @triple.chunk_while { |e, f| e % 3 == 0 }.to_a
    end

    # Case where all elements are nil
    def test_chunk_while_nil
        assert_equal [[nil], [nil], [nil]], @triple_nil.chunk_while { |e, f| e == 5 }.to_a
    end


    # collect

    # Case where values are ints
    def test_collect_int
        assert_equal [4, 3, 10], @triple.collect { |e| e + 1 }
    end

    # Case where values are nil
    def test_collect_nil
        assert_equal [nil, nil, nil], @triple_nil.collect { |e| }
    end


    # collect_concat

    # Case where element is concatenated alongside original
    def test_collect_concat_adjacent
        assert_equal [3, 4, 2, 3, 9, 10], @triple.collect_concat { |e| [e, e + 1] }
    end

    # Case where values are nil
    def test_collect_concat_nil
        assert_equal [nil, nil, nil], @triple_nil.collect_concat { |e| [e] }
    end


    # count

    # Case count
    def test_count
        assert_equal 3, @triple_string.count
    end

    # Case count item
    def test_count_item
        assert_equal 1, @triple_string.count("la")
    end

    # Case count based on block
    def test_count_block
        assert_equal 2, @triple.count { |e| e % 3 == 0 }
    end

    # Case count with nil
    def test_count_nil
        assert_equal 3, @triple_nil.count
    end


    # cycle

    # Ignoring n = nil case as that would run forever

    # Case cycle ends after n = 3 iterations
    def test_cycle_n
        arr = Array.new
        assert_nil @triple.cycle(3) { |e| arr << e * 3 }
        assert_equal [9, 6, 27, 9, 6, 27, 9, 6, 27], arr
    end

    # Case triple contains only nil
    def test_cycle_nil
        arr = Array.new
        assert_nil @triple_nil.cycle(2) { |e| arr << e if e != nil }
        assert_equal [], arr
    end


    # detect

    # Case all match criteria
    def test_detect_allMatch
        assert_equal 3, @triple.detect { |e| e == e }
    end

    # Case none match criteria
    def test_detect_noneMatch
        assert_nil @triple.detect { |e| e == 5 }
    end

    # Case none match criteria, but ifnone specified
    def test_detect_noneMatch_ifnone
        assert_equal 5, @triple.detect(lambda {5}) { |e| e == 7 }
    end

    # Case some match criteria
    def test_detect_someMatch
        assert_equal 2, @triple.detect { |e| e == 2 }
    end

    # Case all nil
    def test_detect_nil
        assert_nil @triple_nil.detect { |e| e != nil }
    end


    # drop

    # Case drop all elements
    def test_drop_allElements
        assert_equal [], @triple.drop(3)
    end

    # Case drop no elements
    def test_drop_noElements
        assert_equal [3, 2, 9], @triple.drop(0)
    end

    # Case drop some elements
    def test_drop_someElements
        assert_equal [9], @triple.drop(2)
    end

    # Case drop nil elements
    def test_drop_nil
        assert_equal [nil, nil], @triple_nil.drop(1)
    end


    # drop_while

    # Case drop all elements
    def test_drop_while_allElements
        assert_equal [], @triple.drop_while { |e| e > 1 }
    end

    # Case drop no elements
    def test_drop_while_noElements
        assert_equal [3, 2, 9], @triple.drop_while { |e| e < 0 }
    end

    # Case drop some elements
    def test_drop_while_someElements
        assert_equal [9], @triple.drop_while { |e| e < 7 }
    end

    # Case drop false elements
    # first element false - none should drop
    def test_drop_while_withFalse
        assert_equal [false, true, true], @triple_bool.drop_while { |e| e }
    end

    # Case drop nil elements
    # first element nil - none should drop
    def test_drop_while_nil
        assert_equal [nil, nil, nil], @triple_nil.drop_while { |e| e }
    end


    # each_cons

    # Elements all together
    def test_each_cons_allTogether
        arr = Array.new
        assert_nil @triple.each_cons(3) { |e| arr << e }
        assert_equal [[3, 2, 9]], arr
    end

    # Elements all separate
    def test_each_cons_noneTogether
        arr = Array.new
        assert_nil @triple.each_cons(1) { |e| arr << e }
        assert_equal [[3], [2], [9]], arr
    end

    # Elements some together
    def test_each_cons_someTogether
        arr = Array.new
        assert_nil @triple.each_cons(2) { |e| arr << e }
        assert_equal [[3, 2], [2, 9]], arr
    end


    # each_entry

    # Case not nil
    def test_each_entry
        assert_equal [3, 2, 9], @triple.each_entry { |e| e }.to_a
    end

    # Case nil
    def test_each_entry_nil
        assert_equal [nil, nil, nil], @triple_nil.each_entry { |e| e }.to_a
    end


    # each_slice

    # Elements all together
    def test_each_slice_allTogether
        arr = Array.new
        assert_nil @triple.each_slice(3) { |e| arr << e }
        assert_equal [[3, 2, 9]], arr
    end

    # Elements all separate
    def test_each_slice_noneTogether
        arr = Array.new
        assert_nil @triple.each_slice(1) { |e| arr << e }
        assert_equal [[3], [2], [9]], arr
    end

    # Elements some together
    def test_each_slice_someTogether
        arr = Array.new
        assert_nil @triple.each_slice(2) { |e| arr << e }
        assert_equal [[3, 2], [9]], arr
    end


    # each_with_index

    # Case not nil
    def test_each_with_index
        arr = Array.new
        @triple.each_with_index { |e, i| arr[i] = e + 1 }
        assert_equal [4, 3, 10], arr
    end

    # Case nil
    def test_each_with_index_nil
        arr = Array.new
        @triple_nil.each_with_index { |e, i| arr[i] = e }
        assert_equal [nil, nil, nil], arr
    end


    # each_with_object

    # Case not nil
    def test_each_with_object
        arr = Array.new
        @triple.each_with_object(arr) { |e| arr << (e + 1) }
        assert_equal [4,3,10], arr
    end

    # Case nil
    def test_each_with_object_nil
        arr = Array.new
        @triple_nil.each_with_object(arr) { |e| arr << e }
        assert_equal [nil, nil, nil], arr
    end


    # entries

    # Case non-nil entries
    def test_entries
        assert_equal [3,2,9], @triple.entries
    end

    # Case nil entries
    def test_entries_nil
        assert_equal [nil,nil,nil], @triple_nil.entries
    end


    # find

    # Case all match criteria
    def test_find_allMatch
        assert_equal 3, @triple.find { |e| e == e }
    end

    # Case none match criteria
    def test_find_noneMatch
        assert_nil @triple.find { |e| e == 5 }
    end

    # Case none match criteria, but ifnone specified
    def test_find_noneMatch_ifnone
        assert_equal 5, @triple.find(lambda {5}) { |e| e == 7 }
    end

    # Case some match criteria
    def test_find_someMatch
        assert_equal 2, @triple.find { |e| e == 2 }
    end

    # Case all nil
    def test_find_nil
        assert_nil @triple_nil.find { |e| e != nil }
    end


    # find_all

    # Case all match criteria
    def test_find_all_allMatch
        assert_equal [3,2,9], @triple.find_all { |e| e == e }
    end

    # Case none match criteria
    def test_find_all_noneMatch
        assert_equal [], @triple.find_all { |e| e == 5 }
    end

    # Case some match criteria
    def test_find_all_someMatch
        assert_equal [2], @triple.find_all { |e| e == 2 }
    end

    # Case all nil
    def test_find_all_nil
        assert_equal [], @triple_nil.find_all { |e| e != nil }
    end


    # find_index

    # Case element is in triple
    def test_find_index_containsValue
        assert_equal 1, @triple.find_index(2)
    end

    # Case element is not in triple
    def test_find_index_notContainsValue
        assert_nil @triple.find_index(17)
    end

    # Case element with matching pattern is in triple
    def test_find_index_someMatch
        assert_equal 0, @triple.find_index { |e| e == 3 }
    end

    # Case element with matching pattern is not in triple
    def test_find_index_noMatch
        assert_nil @triple.find_index { |e| e == 17 }
    end


    # first

    # Grab the first element
    def test_first
        assert_equal 3, @triple.first
    end

    # Grab the first n = 2 elements
    def test_first_n
        assert_equal [3,2], @triple.first(2)
    end

    # Grab the first element of a nil triple
    def test_first_nil
        assert_nil @triple_nil.first
    end

    # Grab the first n = 2 elements of a nil triple
    def test_first_n_nil
        assert_equal [nil, nil], @triple_nil.first(2)
    end


    # flat_map

    # Case where element is concatenated alongside original
    def test_flat_map_adjacent
        assert_equal [3, 4, 2, 3, 9, 10], @triple.flat_map { |e| [e, e + 1] }
    end

    # Case where values are nil
    def test_flat_map_nil
        assert_equal [nil, nil, nil], @triple_nil.flat_map { |e| [e] }
    end


    # grep

    # Case none match criteria
    def test_grep_noneMatch
        assert_equal [], @triple.grep(5)
    end

    # Case some match criteria
    def test_grep_someMatch
        assert_equal [2], @triple.grep(2)
    end

    # Case all nil
    def test_grep_nil
        assert_equal [], @triple_nil.grep(6)
    end

    # Case none match criteria with block
    def test_grep_noneMatch_block
        arr = Array.new
        @triple.grep(5) { |e| arr << e}
        assert_equal [], arr
    end

    # Case some match criteria with block
    def test_grep_someMatch_block
        arr = Array.new
        @triple.grep(2) { |e| arr << e}
        assert_equal [2], arr
    end

    # Case all nil with block
    def test_grep_nil_block
        arr = Array.new
        @triple_nil.grep(6) { |e| arr << e}
        assert_equal [], arr
    end


    # grep_v

    # Case none match criteria
    def test_grep_v_noneMatch
        assert_equal [3, 2, 9], @triple.grep_v(5)
    end

    # Case some match criteria
    def test_grep_v_someMatch
        assert_equal [3, 9], @triple.grep_v(2)
    end

    # Case all nil
    def test_grep_v_nil
        assert_equal [nil, nil, nil], @triple_nil.grep_v(6)
    end

    # Case none match criteria with block
    def test_grep_v_noneMatch_block
        arr = Array.new
        @triple.grep_v(5) { |e| arr << e}
        assert_equal [3, 2, 9], arr
    end

    # Case some match criteria with block
    def test_grep_v_someMatch_block
        arr = Array.new
        @triple.grep_v(2) { |e| arr << e}
        assert_equal [3, 9], arr
    end

    # Case all nil with block
    def test_grep_v_nil_block
        arr = Array.new
        @triple_nil.grep_v(6) { |e| arr << e}
        assert_equal [nil, nil, nil], arr
    end


    # group_by

    # Case non-nil elements
    def test_group_by
        hash = {4=>[3], 3=>[2], 10=>[9]}
        assert_equal hash, @triple.group_by { |e| e + 1 }
    end

    # Case nil elements
    def test_group_by_nil
        hash = {nil=>[nil, nil, nil]}
        assert_equal hash, @triple_nil.group_by { |e| e }
    end


    # include

    # Case object is in triple
    def test_include_true
        assert @triple.include? 2
    end

    # Case object is not in triple
    def test_include_false
        assert !(@triple.include? 7)
    end


    # inject

    # Case inject without specified initial
    def test_inject
        assert_equal 54, @triple.inject(:*)
    end

    # Case inject starting at 2
    def test_inject_initial
        assert_equal 108, @triple.inject(2, :*)
    end

    # Case inject without specified initial using block
    def test_inject_block
        assert_equal 54, @triple.inject { |prod, e| prod * e }
    end

    # Case inject with specified initial using block
    def test_inject_initial_block
        assert_equal 108, @triple.inject(2) { |prod, e| prod * e }
    end


    # map

    # Case where values are ints
    def test_map_int
        assert_equal [4, 3, 10], @triple.map { |e| e + 1 }
    end

    # Case where values are nil
    def test_map_nil
        assert_equal [nil, nil, nil], @triple_nil.map { |e| e }
    end


    # max

    # Case find max string
    def test_max
        assert_equal "la", @triple_string.max
    end

    # Case find int with alternate max defined in block
    # this finds min since comparator operator reverses signs
    def test_max_block
        assert_equal 2, @triple.max { |e, f| -e <=> -f }
    end

    # Case find max string
    def test_max_n
        assert_equal ["la", "di"], @triple_string.max(2)
    end

    # Case find int with alternate max defined in block
    # this finds min since comparator operator reverses signs
    def test_max_n_block
        assert_equal [2,3], @triple.max(2) { |e, f| -e <=> -f }
    end


    # max_by

    # Case find int with alternate max defined in block
    # this finds min since sign is reversed
    def test_max_by
        assert_equal 2, @triple.max_by { |e| -e }
    end

    # Case find int with alternate max defined in block
    # this finds min since sign is reversed
    def test_max_by_n
        assert_equal [2,3], @triple.max_by(2) { |e| -e }
    end


    # member?

    # Case object is in triple
    def test_member_true
        assert @triple.member? 2
    end

    # Case object is not in triple
    def test_member_false
        assert !(@triple.member? 7)
    end


    # min

    # Case find min string
    def test_min
        assert_equal "da", @triple_string.min
    end

    # Case find int with alternate min defined in block
    # this finds max since comparator operator reverses signs
    def test_min_block
        assert_equal 9, @triple.min { |e, f| -e <=> -f }
    end

    # Case find min string
    def test_min_n
        assert_equal ["da", "di"], @triple_string.min(2)
    end

    # Case find int with alternate min defined in block
    # this finds max since comparator operator reverses signs
    def test_min_n_block
        assert_equal [9,3], @triple.min(2) { |e, f| -e <=> -f }
    end


    # min_by

    # Case find int with alternate min defined in block
    # this finds max since sign is reversed
    def test_min_by
        assert_equal 9, @triple.min_by { |e| -e }
    end

    # Case find int with alternate min defined in block
    # this finds max since sign is reversed
    def test_min_by_n
        assert_equal [9,3], @triple.min_by(2) { |e| -e }
    end


    # minmax

    # Case find max and min strings
    def test_min_max
        assert_equal ["da", "la"], @triple_string.minmax
    end

    # Case find ints with alternate min and max defined in block
    # this flips min and max since comparator operator reverses signs
    def test_min_max_block
        assert_equal [9, 2], @triple.minmax { |e, f| -e <=> -f }
    end


    # minmax_by

    # Case find ints with alternate min and max defined in block
    # this flips min and max since sign is reversed
    def test_min_max_by
        assert_equal [9, 2], @triple.minmax_by { |e| -e }
    end


    # none?

    # Case where all meet criteria
    def test_none_allMatch
        assert !(@triple.none? { |e| e == e })
    end

    # Case where none meet criteria
    def test_none_noneMatch
        assert @triple.none? { |e| e % 5 == 1 }
    end

    # Case where some meet criteria
    def test_none_someMatch
        assert !(@triple.none? { |e| e % 3 == 0 })
    end

    # Case with nil
    def test_none_nil
        assert @triple_nil.none?
    end


    # one?

    # Case where all meet criteria
    def test_one_allMatch
        assert !(@triple.one? { |e| e == e })
    end

    # Case where none meet criteria
    def test_one_noneMatch
        assert !(@triple.one? { |e| e % 5 == 1 })
    end

    # Case where one meets criteria
    def test_one_oneMatch
        assert @triple.one? { |e| e % 3 == 2 }
    end

    # Case with nil
    def test_one_nil
        assert !(@triple_nil.one?)
    end


    # partition

    # Case where all meet criteria
    def test_partition_allMatch
        assert_equal [[3, 2, 9], []], @triple.partition { |e| e == e }
    end

    # Case where none meet criteria
    def test_partition_noneMatch
        assert_equal [[], [3, 2, 9]], @triple.partition { |e| e % 5 == 1 }
    end

    # Case where some meet criteria
    def test_partition_someMatch
        assert_equal [[3, 9], [2]], @triple.partition { |e| e % 3 == 0 }
    end

    # Case with nil
    def test_partition_nil
        assert [[], [nil, nil, nil]], @triple_nil.partition { |e| e }
    end


    # reduce

    # Case reduce without specified initial
    def test_reduce
        assert_equal 54, @triple.reduce(:*)
    end

    # Case reduce starting at 2
    def test_reduce_initial
        assert_equal 108, @triple.reduce(2, :*)
    end

    # Case reduce without specified initial using block
    def test_reduce_block
        assert_equal 54, @triple.reduce { |prod, e| prod * e }
    end

    # Case reduce with specified initial using block
    def test_reduce_initial_block
        assert_equal 108, @triple.reduce(2) { |prod, e| prod * e }
    end


    # reject

    # Case all match criteria
    def test_reject_allMatch
        assert_equal [], @triple.reject { |e| e == e }
    end

    # Case none match criteria
    def test_reject_noneMatch
        assert_equal [3, 2, 9], @triple.reject { |e| e % 5 == 1 }
    end

    # Case some match criteria
    def test_reject_someMatch
        assert_equal [2], @triple.reject { |e| e % 3 == 0 }
    end

    # Case all nil
    def test_reject_nil
        assert_equal [], @triple_nil.reject { |e| e == nil }
    end


    # reverse_each

    # Case reverse ints
    def test_reverse_each
        arr = Array.new
        @triple.reverse_each() { |e| arr << (e + 1) }
        assert_equal [10, 3, 4], arr
    end

    # Case all nil
    def test_reverse_each_nil
        arr = Array.new
        @triple_nil.reverse_each() { |e| arr << e  }
        assert_equal [nil, nil, nil], arr
    end


    # select

    # Case all match criteria
    def test_select_allMatch
        assert_equal [3,2,9], @triple.select { |e| e == e }
    end

    # Case none match criteria
    def test_select_noneMatch
        assert_equal [], @triple.select { |e| e == 5 }
    end

    # Case some match criteria
    def test_select_someMatch
        assert_equal [2], @triple.select { |e| e == 2 }
    end

    # Case all nil
    def test_select_nil
        assert_equal [], @triple_nil.select { |e| e != nil }
    end


    # slice_after

    # Case some match pattern
    def test_slice_after_someMatch
        assert_equal [[3, 2], [9]], @triple.slice_after(2).to_a
    end

    # Case none match pattern
    def test_slice_after_noneMatch
        assert_equal [[3, 2, 9]], @triple.slice_after(10).to_a
    end

    # Case all nil
    def test_slice_after_nil
        assert_equal [[nil], [nil], [nil]], @triple_nil.slice_after(nil).to_a
    end

    # Case all match pattern
    def test_slice_after_allMatch_block
        assert_equal [[3], [2], [9]], @triple.slice_after { |e| e == e }.to_a
    end

    # Case some match pattern
    def test_slice_after_someMatch_block
        assert_equal [[3], [2, 9]], @triple.slice_after { |e| e % 3 == 0 }.to_a
    end

    # Case none match pattern
    def test_slice_after_noneMatch_block
        assert_equal [[3, 2, 9]], @triple.slice_after { |e| e % 5 == 1 }.to_a
    end

    # Case all nil
    def test_slice_after_nil_block
        assert_equal [[nil], [nil], [nil]], @triple_nil.slice_after { |e| e == nil }.to_a
    end


    # slice_before

    # Case some match pattern
    def test_slice_before_someMatch
        assert_equal [[3], [2, 9]], @triple.slice_before(2).to_a
    end

    # Case none match pattern
    def test_slice_before_noneMatch
        assert_equal [[3, 2, 9]], @triple.slice_before(10).to_a
    end

    # Case all match pattern
    def test_slice_before_allMatch_block
        assert_equal [[3], [2], [9]], @triple.slice_before { |e| e == e }.to_a
    end

    # Case some match pattern
    def test_slice_before_someMatch_block
        assert_equal [[3, 2], [9]], @triple.slice_before { |e| e % 3 == 0 }.to_a
    end

    # Case none match pattern
    def test_slice_before_noneMatch_block
        assert_equal [[3, 2, 9]], @triple.slice_before { |e| e % 5 == 1 }.to_a
    end

    # Case all nil
    def test_slice_before_nil_block
        assert_equal [[nil], [nil], [nil]], @triple_nil.slice_before { |e| e == nil }.to_a
    end


    # slice_when

    # Case all match pattern
    def test_slice_when_allMatch
        assert_equal [[3], [2], [9]], @triple.slice_when { |e, f| e != f }.to_a
    end

    # Case some match pattern
    def test_slice_when_someMatch
        assert_equal [[3], [2, 9]], @triple.slice_when { |e, f| e == f + 1 }.to_a
    end

    # Case none match pattern
    def test_slice_when_noneMatch
        assert_equal [[3, 2, 9]], @triple.slice_when { |e, f| e == f }.to_a
    end

    # Case all nil
    def test_slice_when_nil
        assert_equal [[nil], [nil], [nil]], @triple_nil.slice_when { |e, f| e == f }.to_a
    end


    # sort

    # Case basic sort
    def test_sort
        assert_equal [2, 3, 9], @triple.sort
    end

    # Case sort with custom comparator (reverse sort in this case)
    def test_sort_block
        assert_equal [9, 3, 2], @triple.sort { |e, f| -e <=> -f }
    end


    # sort_by

    # Case sort with custom comparator (reverse sort in this case)
    def test_sort_by
        assert_equal [9, 3, 2], @triple.sort_by { |e| -e }
    end


    # sum

    # Case basic sum without initial
    def test_sum
        assert_equal 14, @triple.sum
    end

    # Case basic sum with initial
    def test_sum_initial
        assert_equal 20, @triple.sum(6)
    end

    # Case custom sum without initial
    def test_sum_block
        assert_equal 94, @triple.sum { |e| e * e }
    end

    # Case custom sum with initial
    def test_sum_block_initial
        assert_equal 100, @triple.sum(6) { |e| e * e }
    end


    # take

    # Case take some elements
    def test_take
        assert_equal [3, 2], @triple.take(2)
    end

    # Case take no elements
    def test_take_none
        assert_equal [], @triple.take(0)
    end


    # take_while

    # Case some elements match
    def test_take_while
        assert_equal [3], @triple.take_while { |e| e % 3 == 0 }
    end

    # Case no elements match
    def test_take_while_none
        assert_equal [], @triple.take_while { |e| e % 5 == 1 }
    end


    # to_a

    # Case convert to int array
    def test_to_a
        assert_equal [3, 2, 9], @triple.to_a
    end

    # Case convert into nil array
    def test_to_a_nil
        assert_equal [nil, nil, nil], @triple_nil.to_a
    end


    # uniq

    # Case all unique values
    def test_uniq
        assert_equal [3, 2, 9], @triple.uniq
    end

    # Case with duplicates
    def test_uniq_dupes
        assert_equal [false, true], @triple_bool.uniq
    end

    # Case with duplicates and item specified
    def test_uniq_item_dupes
        assert_equal [false, true], @triple_bool.uniq { |e| e == false }
    end


    # zip

    # Case zip int triple with bool triple
    def test_zip
        assert_equal [[3, false], [2, true], [9, true]], @triple.zip(@triple_bool)
    end

    # Case zip int triple with itself with subtraction as the joining operation
    def test_zip_block
        arr = Array.new
        assert_nil @triple.zip(@triple) { |e, f| arr << e - f }
        assert_equal [0, 0, 0], arr
    end


end
