require 'minitest/autorun'

class KedgetteUnitTests < Minitest::Test

  def setup
    @integers = Triple.new(1, 2, 3)
    @strings = Triple.new("Kyle", "Preston", "Renato")

  end

  # all?[{ |obj| block }] → true or false

  def test_all_ints
    result = @integers.all? do |num|
      num != 0
    end

    assert_equal result, true
  end

  def test_all_ints_2
    result = @integers.all? do |num|
      num > 2
    end

    assert_equal result, false
  end

  def test_all_strings
    result = @strings.all? do |name|
      name.length != 0
    end

    assert_equal result, true
  end

  def test_all_strings_2
    result = @strings.all? do |name|
      name.length > 5
    end

    assert_equal result, false
  end

  # any?[{ |obj| block }] → true or false

  def test_any_ints
    result = @integers.any? do |num|
      num != 0
    end

    assert_equal result, true
  end

  def test_any_ints_2
    result = @integers.any? do |num|
      num > 2
    end

    assert_equal result, true
  end

  def test_any_strings
    result = @strings.any? do |name|
      name.length != 0
    end

    assert_equal result, true
  end

  def test_any_strings_2
    result = @strings.any? do |name|
      name.length > 5
    end

    assert_equal result, true
  end


  # # chunk { |elt| ... } → array
  # # chunk_while { |elt_before,elt_after| bool } → array
  #
  #
  # collect { |obj| block } → array % same as map

  def test_collect_ints
    results = @integers.collect do |num|
      num*num
    end

    assert_equal results, [1, 4, 9]
  end

  def test_collect_strings
    results = @strings.collect do |name|
      name + '!'
    end

    assert_equal results, ['Kyle!', 'Preston!', 'Renato!']
  end

  # collect_concat { |obj| block } → array % same as flat_map

  def test_collect_concat_ints
    results = @integers.collect_concat do |num|
      num*num
    end

    assert_equal results, [1, 4, 9]
  end

  def test_collect_concat_strings
    results = @strings.collect_concat do |name|
      name + '!'
    end

    assert_equal results, ['Kyle!','Preston!', 'Renato!']
  end


  # count { |obj| block } → int

  def test_count_ints
    result = @integers.count

    assert_equal result, 3

  end

  def test_count_strings
    result = @strings.count

    assert_equal result, 3

  end

  # count(item) → int

  def test_count_2_ints

    result = @integers.count(2)

    assert_equal result, 1

  end

  def test_count_4_ints

    result = @integers.count(4)

    assert_equal result, 0

  end

  def test_count_kyle_strings

    result = @strings.count("Kyle")

    assert_equal result, 1

  end

  def test_count_allison_strings

    result = @strings.count("Allison")

    assert_equal result, 0

  end


  # count { |obj| block } → int

  def test_count_block_1_ints
    result = @integers.count do |number|
      number>2
    end

    assert_equal result, 1
  end

  def test_count_block_2_ints
    result = @integers.count do |number|
      number<4
    end

    assert_equal result, 3
  end

  def test_count_block_1_string
    result = @strings.count do |name|
      name.eql? 'Kyle'
    end

    assert_equal result, 1
  end

  def test_count_block_2_string
    result = @strings.count do |name|
      name.eql? 'Wilson'
    end

    assert_equal result, 0
  end



  # cycle(n=nil) { |obj| block } → nil

  def test_cycle_ints
    result = @integers.cycle(3) do |number|
      print number
    end

    assert_nil result, nil
  end

  def test_cycle_string
    result = @strings.cycle(3) do |name|
      print name
    end

    assert_nil result, nil
  end


  # detect(ifnone = nil) { |obj| block } → obj or nil

  def test_detect_1_ints
    result = @integers.detect do |number|
      number%2 == 0
    end

    assert_equal result, 2
  end

  def test_detect_2_ints
    result = @integers.detect(nil) do |number|
      number%5 == 0
    end

    assert_nil result, nil
  end

  def test_detect_1_strings
    result = @strings.detect(nil) do |name|
      name > 'Allison'
    end

    assert_equal result, 'Kyle'
  end

  def test_detect_2_strings
    result = @strings.detect(nil) do |name|
      name < 'Allison'
    end

    assert_nil result, nil
  end


  # drop(n) → array

  def test_drop_ints
    result = @integers.drop(1)


    assert_equal result, [2, 3]
  end

  def test_drop_strings
    result = @strings.drop(2)


    assert_equal result, ["Renato"]
  end


  # drop_while { |arr| block } → array

  def test_drop_while_ints
    result = @integers.drop_while do |num|
      num<3
    end

    assert_equal result, [3]
  end

  def test_drop_while_strings
    result = @strings.drop_while do |name|
      name<'Liz'
    end

    assert_equal result, ["Preston", "Renato"]
  end


  # # each_cons(n) { ... } → nil
  #
  # def test_each_cons_ints
  #
  #   result = @integers.each_cons(2) do |number|
  #     print number
  #   end
  #
  #   assert_nil result, nil
  # end
  #
  # def test_each_cons_strings
  #
  #   result = @strings.each_cons(2) do |name|
  #     print name
  #   end
  #
  #   assert_nil result, nil
  # end
  #
  #
  # # each_entry{ |obj| block } → enum
  #
  #
  #
  # each_slice(n) { ... } → nil

  def test_each_slice_ints

    result = @integers.each_slice(2) do |number|
      print number
    end

    assert_nil result, nil
  end

  def test_each_slice_strings

    result = @strings.each_slice(1) do |name|
      print name
    end

    assert_nil result, nil
  end



  # each_with_index(*args) { |obj, i| block } → enum

  def test_each_with_ints

    result = @integers.each_with_index do |num, index|
      print num.to_s + 'at index ' + index.to_s
    end

    assert_equal result, @integers

  end


  # each_with_object(obj) { |(*args), memo_obj| ... } → obj

  def test_each_with_object_ints

    result = @integers.each_with_object([]) do |i, mem|
      mem << i * 3
    end

    assert_equal result, [3, 6, 9]
  end

  def test_each_with_object_string

    result = @strings.each_with_object([]) do |i, mem|
      mem << i + '!'
    end


    assert_equal result, ["Kyle!", "Preston!", "Renato!"]
  end


  # entries(*args) → array

  def test_entries_ints

    result = @integers.entries

    assert_equal result, [1, 2, 3]

  end

  def test_entries_string

    result = @strings.entries

    assert_equal result, ["Kyle", "Preston", "Renato"]

  end

  # find(ifnone = nil) { |obj| block } → obj or nil

  def test_find_1_ints
    result = @integers.find do |number|
      number%2 == 0
    end

    assert_equal result, 2
  end

  def test_find_2_ints
    result = @integers.find(nil) do |number|
      number%5 == 0
    end

    assert_nil result, nil
  end

  def test_find_1_strings
    result = @strings.find(nil) do |name|
      name > 'Allison'
    end

    assert_equal result, 'Kyle'
  end

  def test_find_2_strings
    result = @strings.find(nil) do |name|
      name < 'Allison'
    end

    assert_nil result, nil
  end


  # find_all { |obj| block } → array % same as select

  def test_find_all_ints

    result = @integers.find_all do |num|
      num % 2 == 0
    end

    assert_equal result, [2]

  end

  def test_find_all_strings

    result = @strings.find_all do |name|
      name.eql? 'Kyle'
    end

    assert_equal result, ['Kyle']

  end

  # find_index(value) → int or nil

  def test_find_index_ints

    result = @integers.find_index(3)

    assert_equal result, 2

  end

  def test_find_index_ints_2

    result = @integers.find_index(45)

    assert_nil result, nil

  end

  def test_find_index_strings

    result = @strings.find_index("Preston")

    assert_equal result, 1

  end

  def test_find_index_strings_2

    result = @strings.find_index("Anna")

    assert_nil result, nil

  end

  # find_index { |obj| block } → int or nil

  def test_find_index_ints_block

    result = @integers.find_index do |num|
      num > 1
    end

    assert_equal result, 1

  end

  def test_find_index_ints_2_block

    result = @integers.find_index do |num|
      num > 30
    end

    assert_nil result, nil

  end

  def test_find_index_strings_block

    result = @strings.find_index do |name|
      name < 'Quinn'
    end

    assert_equal result, 0

  end

  def test_find_index_strings_2_block

    result = @strings.find_index do |name|
      name < 'Anna'
    end

    assert_nil result, nil

  end


  # first → obj or nil

  def test_first_ints

    result = @integers.first

    assert_equal result, 1

  end

  def test_first_strings

    result = @strings.first

    assert_equal result, "Kyle"

  end

  # first(n) → an_array

  def test_first_ints_2

    result = @integers.first(2)

    assert_equal result, [1, 2]

  end

  def test_first_strings_2

    result = @strings.first(3)

    assert_equal result, ["Kyle", "Preston", "Renato"]

  end

  # flat_map { |obj| block } → array %same as collect_concat

  def test_flat_map_ints
    results = @integers.flat_map do |num|
      num*num
    end

    assert_equal results, [1, 4, 9]
  end

  def test_flat_map_strings
    results = @strings.flat_map do |name|
      name + '!'
    end

    assert_equal results, ['Kyle!','Preston!', 'Renato!']
  end

  # grep(pattern) → array

  def test_grep_ints

    result = @integers.grep 1

    assert_equal result, [1]

  end

  def test_grep_strings

    result = @strings.grep 'Preston'

    assert_equal result, ['Preston']

  end

  # grep(pattern) { |obj| block} → array

  def test_grep_ints_2

    result = @integers.grep(1) do |num|
      print num
    end

    print result

    assert_equal result, [nil]

  end

  def test_grep_strings_2

    result = @strings.grep('Preston')  do |name|
      print name
    end

    assert_equal result, [nil]

  end

  # grep_v(pattern) → array

  def test_grep_v_ints

    result = @integers.grep_v 1

    assert_equal result, [2, 3]

  end

  def test_grep_v_strings

    result = @strings.grep_v /Preston/

    assert_equal result, ['Kyle', 'Renato']

  end


  # grep_v(pattern) { |obj| block } → array

  def test_grep_v_ints_2

    result = @integers.grep_v(1) do |num|
      print num
    end

    print result

    assert_equal result, [nil, nil]

  end

  def test_grep_v_strings_2

    result = @strings.grep_v(/Preston/)  do |name|
      print name
    end

    assert_equal result, [nil, nil]

  end


  # group_by { |obj| block } → a_hash


  def test_group_by
    result = @integers.group_by do |num|
      num % 2
    end

    hash = {0 => [2],1=>[1,3]}


    assert_equal hash, result
  end


  # include?(obj) → true or false %same as member

  def test_include_int_1
    result = @integers.include? 2

    assert_equal result, true
  end

  def test_include_int_2
    result = @integers.include? 4

    assert_equal result, false
  end

  def test_include_strings_1
    result = @strings.include? 'Kyle'

    assert_equal result, true
  end

  def test_include_strings_2
    result = @strings.include? 'Toby'

    assert_equal result, false
  end

  # # inject(initial, sym) → obj %same as reduce (all of inject)
  #
  #
  #
  # # inject(sym) → obj
  # # inject(initial) { |memo, obj| block } → obj
  # # inject { |memo, obj| block } → obj
  #
  # map { |obj| block } → array % same as collect

  def test_map_ints
    results = @integers.map do |num|
      num*num
    end

    assert_equal results, [1, 4, 9]
  end

  def test_map_strings
    results = @strings.map do |name|
      name + '!'
    end

    assert_equal results, ['Kyle!', 'Preston!', 'Renato!']
  end


  # max → obj

  def test_max_ints
    result = @integers.max

    assert_equal result, 3
  end

  def test_max_strings
    result = @strings.max

    assert_equal result, 'Renato'
  end

  # max { |a, b| block } → obj

  def test_max_ints_2
    result = @integers.max do |a, b|
      a%2 <=> b%2
    end

    assert_equal result, 1
  end

  def test_max_strings_2
    result = @strings.max do |a, b|
      a.length <=> b.length
    end

    assert_equal result, 'Preston'
  end


  # max(n) → array

  def test_max_ints_n
    result = @integers.max(2)

    assert_equal result, [3,2]
  end

  def test_max_strings_n
    result = @strings.max(2)

    assert_equal result, ['Renato', 'Preston']
  end

  # max(n) {|a,b| block } → obj

  def test_max_ints_2_n
    result = @integers.max(2) do |a, b|
      (a%2) <=> (b%2)
    end

    assert_equal result, [3, 1]
  end

  def test_max_strings_2_n
    result = @strings.max(2) do |a, b|
      a.length <=> b.length
    end

    assert_equal result, ['Preston', 'Renato']
  end

  # max_by {|obj| block } → obj

  def test_max_by_ints
    result = @integers.max_by do |num|
      num%2
    end

    assert_equal result, 1
  end

  def test_max_by_strings
    result = @strings.max_by do |name|
      name.length
    end

    assert_equal result, 'Preston'
  end

  # max_by(n) {|obj| block } → obj

  def test_max_by_ints_n
    result = @integers.max_by(2) do |num|
      num%2
    end

    assert_equal result, [3,1]
  end

  def test_max_by_strings_n
    result = @strings.max_by(2) do |name|
      name.length
    end

    assert_equal result, ['Preston', 'Renato']
  end

  # member?(obj) → true or false %same as include

  def test_member_int_1
    result = @integers.member? 2

    assert_equal result, true
  end

  def test_member_int_2
    result = @integers.member? 4

    assert_equal result, false
  end

  def test_member_strings_1
    result = @strings.member? 'Kyle'

    assert_equal result, true
  end

  def test_member_strings_2
    result = @strings.member? 'Toby'

    assert_equal result, false
  end

  # min → obj

  def test_min_ints
    result = @integers.min

    assert_equal result, 1
  end

  def test_min_strings
    result = @strings.min

    assert_equal result, 'Kyle'
  end

  # min { |a, b| block } → obj

  def test_min_ints_2
    result = @integers.min do |a, b|
      a%2 <=> b%2
    end

    assert_equal result, 2
  end

  def test_min_strings_2
    result = @strings.min do |a, b|
      a.length <=> b.length
    end

    assert_equal result, 'Kyle'
  end


  # min(n) → array

  def test_min_ints_n
    result = @integers.min(2)

    assert_equal result, [1,2]
  end

  def test_min_strings_n
    result = @strings.min(2)

    assert_equal result, ['Kyle', 'Preston']
  end

  # min(n) {|a,b| block } → obj

  def test_min_ints_2_n
    result = @integers.min(2) do |a, b|
      (a%2) <=> (b%2)
    end

    assert_equal result, [2, 3]
  end

  def test_min_strings_2_n
    result = @strings.min(2) do |a, b|
      a.length <=> b.length
    end

    assert_equal result, ['Kyle', 'Renato']
  end

  # min_by {|obj| block } → obj

  def test_min_by_ints
    result = @integers.min_by do |num|
      num%2
    end

    assert_equal result, 2
  end

  def test_min_by_strings
    result = @strings.min_by do |name|
      name.length
    end

    assert_equal result, 'Kyle'
  end

  # min_by(n) {|obj| block } → obj

  def test_min_by_ints_n
    result = @integers.min_by(2) do |num|
      num%2
    end

    assert_equal result, [2, 3]
  end

  def test_min_by_strings_n
    result = @strings.min_by(2) do |name|
      name.length
    end

    assert_equal result, ['Kyle', 'Renato']
  end


  # minmax → [min, max]

  def test_minmax_ints
    result = @integers.minmax

    assert_equal result, [1, 3]
  end

  def test_minmax_strings
    result = @strings.minmax

    assert_equal result, ['Kyle', 'Renato']
  end

  # minmax { |a, b| block } → [min, max]

  def test_minmax_ints_2
    result = @integers.minmax do |a, b|
      a*a <=> b*b
    end

    assert_equal result, [1, 3]
  end

  def test_minmax_strings_2
    result = @strings.minmax do |a, b|
      a.length <=> b.length
    end

    assert_equal result, ['Kyle', 'Preston']
  end

  # minmax_by { |obj| block } → [min, max]

  def test_minmax_by_ints
    result = @integers.minmax_by do |a|
      a*a
    end

    assert_equal result, [1, 3]
  end

  def test_minmax_by_strings
    result = @strings.minmax_by do |a|
      a.length
    end

    assert_equal result, ['Kyle', 'Preston']
  end

  # none? { |obj| block } → true or false

  def test_none_integers

    result = @integers.none? do |num|
      num*num == 25
    end

    assert_equal result, true
  end

  def test_none_strings

    result = @strings.none? do |name|
      name.length < 5
    end

    assert_equal result, false
  end


  # one? { |obj| block } → true or false

  def test_one_integers

    result = @integers.one? do |num|
      num*num == 9
    end

    assert_equal result, true
  end

  def test_one_strings

    result = @strings.one? do |name|
      name.length < 5
    end

    assert_equal result, true
  end

  # partition { |obj| block } → [ true_array, false_array ]

  def test_partition_ints

    result = @integers.partition do |num|
      num.even?
    end

    assert_equal result, [[2], [1, 3]]

  end

  def test_partition_strings

    result = @strings.partition do |name|
      name.length == 4
    end

    assert_equal result, [['Kyle'], ['Preston', 'Renato']]

  end

  # # reduce %see inject above
  #
  #
  # reject { |obj| block } → array

  def test_reject_ints

    result = @integers.reject do |num|
      num > 2
    end

    assert_equal result, [1, 2]

  end

  def test_reject_strings

    result = @strings.reject do |name|
      name.length > 5
    end

    assert_equal result, ['Kyle']

  end

  # # reverse_each(*args) { |item| block } → enum
  #
  # select { |obj| block } → array % same as find_all

  def test_select_ints

    result = @integers.select do |num|
      num % 2 == 0
    end

    assert_equal result, [2]

  end

  def test_select_strings

    result = @strings.select do |name|
      name.eql? 'Kyle'
    end

    assert_equal result, ['Kyle']

  end


  # slice_after(pattern) → array
  # slice_after { |elt| bool } → array

  def test_slice_after_ints

    result = @integers.slice_after(2)

    assert_equal [[1,2],[3]], result
  end

  def test_slice_after_strings

    result = @strings.slice_after('Preston')

    assert_equal [['Kyle', 'Preston'],['Renato']], result
  end



  # # slice_before(pattern) → array
  # # slice_before { |elt| bool } → array

  def test_slice_before_ints

    result = @integers.slice_before(2)

    assert_equal [[1],[2,3]], result
  end

  def test_slice_before_strings

    result = @strings.slice_before('Preston')

    assert_equal [['Kyle'],['Preston','Renato']], result
  end


  # slice_when { |elt_before, elt_after| bool } → array

  def test_slice_when_ints

    result = @integers.slice_when do |a, b|
      a+b>4
    end

    assert_equal [[1,2],[3]], result
  end

  def test_slice_when_strings

    result = @strings.slice_when do |a,b|
      a.length < b.length
    end

    assert_equal [['Kyle'],['Preston','Renato']], result
  end

  # sort { |a, b| block } → array

  def test_sort_ints

    result = @integers.sort do |a, b|
      a <=> b
    end

    assert_equal result, [1, 2, 3]

  end

  def test_sort_strings

    result = @strings.sort do |a, b|
      a.length <=> b.length
    end

    assert_equal result, ['Kyle', 'Renato', 'Preston']

  end

  # sort_by { |obj| block } → array

  def test_sort_by_ints

    result = @integers.sort_by do |a|
      a
    end

    assert_equal result, [1, 2, 3]

  end

  def test_sort_by_strings

    result = @strings.sort_by do |a|
      a.length
    end

    assert_equal result, ['Kyle', 'Renato', 'Preston']

  end

  # sum(init=0) → number

  def test_sum_ints
    result = @integers.sum

    assert_equal result, 6
  end

  # sum(init=0) { |e| expr } → number

  def test_sum_ints_1
    result = @integers.sum do |num|
      num*2
    end

    assert_equal result, 12
  end

  # take(n) → array

  def test_take_ints
    result = @integers.take 2

    assert_equal result, [1, 2]
  end

  def test_take_strings
    result = @strings.take 1

    assert_equal result, ['Kyle']
  end

  # take_while { |obj| block } → array

  def test_take_while_ints
    result = @integers.take_while do |num|
      num < 3
    end

    assert_equal result, [1, 2]
  end

  def test_take_while_strings
    result = @strings.take_while do |name|
      name.length < 5
    end

    assert_equal result, ['Kyle']
  end

  # to_a(*args) → array

  def test_to_a_ints
    result = @integers.to_a

    assert_equal result, [1, 2, 3]
  end

  def test_to_a_strings
    result = @strings.to_a

    assert_equal result, ['Kyle', 'Preston', 'Renato']
  end

  # # to_h(*args) → hash
  #
  # uniq → new_ary

  def test_uniq_ints
    result = @integers.uniq

    assert_equal result, [1, 2, 3]
  end

  def test_uniq_strings
    result = @strings.uniq

    assert_equal result, ['Kyle', 'Preston', 'Renato']
  end

  # uniq → { |item| ... } → new_ary

  def test_uniq_ints_2
    result = @integers.uniq do |num|
      num*2
    end

    assert_equal result, [1, 2, 3]
  end

  def test_uniq_strings_2
    result = @strings.uniq do |name|
      name.length
    end

    assert_equal result, ['Kyle', 'Preston', 'Renato']
  end

  # zip(arg, ...) → an_array_of_array

  def test_zip_ints
    result = @integers.zip([4, 5, 6])

    assert_equal result, [[1,4],[2,5],[3,6]]
  end

  def test_zip_strings
    result = @strings.zip([4, 5, 6])

    assert_equal result, [['Kyle',4],['Preston',5],['Renato',6]]
  end

  # zip(arg, ...) → { |arr| block } → nil

  def test_zip_ints_2
    c = []
    result = @integers.zip([4, 5, 6]) do |a, b|
      c << a + b
    end

    assert_nil result, nil
  end

end