#load 'enum2.rb'

require 'minitest/autorun'

class OgbuibeEnumerableTests < Minitest::Test

	def setup
		
	end

	# Triple.new(100,200,300)

	# Jude's tests

  	def test_AllCase1_j
		assert_equal false, Triple.new(100,200,300).all? {|e| e < 100}
  	end

  	def test_AllCase2_j
		assert_equal true, Triple.new(100,200,300).all? {|e| e >= 100}
  	end

  	def test_Any1_j
  		assert_equal true, Triple.new(100,200,300).any? {|item| item = 200}
  	end

  	def test_Min_j
  		assert_equal 100, Triple.new(100,200,300).min
  	end

  	def test_Max_j
  		assert_equal 300, Triple.new(100,200,300).max
  	end

  	def test_Count_j
  		assert_equal 3, Triple.new(100,200,300).count
  	end

  	def test_CountItem_j
  		assert_equal 1, Triple.new(100,200,300).count(100)
  	end

  	def test_FindIndex_j
  		assert_equal 2, Triple.new(100,200,300).find_index(300)
  	end

  	def test_Include_j
  		assert true , Triple.new(100,200,300).include?(300)
  	end

  	# Triple.new('Dog', 'Goat', 'Cat')

  	def test_Find_j
  		assert_equal "Dog", Triple.new('Dog', 'Goat', 'Cat').find {|element| element = 'Dog'}
  	end

  	def test_Select_j
  		assert_equal [100, 200], Triple.new(100,200,300).select {|element| element <= 200}
  	end

  	def test_Reject_j
  		assert_equal [300], Triple.new(100,200,300).reject {|element| element <= 200}
  	end

  	def test_First_j
  		assert_equal 100, Triple.new(100,200,300).first 

  	end

  	def test_First_j
  		assert_equal "Dog", Triple.new('Dog', 'Goat', 'Cat').first 
  	end

  	def test_Map_j
  		assert_equal [200, 400, 600], Triple.new(100,200,300).map {|item| item*2}
  	end

  	def test_cycle_j
  		assert_equal 6, Triple.new(100,200,300).cycle(2).count
  	end

  	def test_cycle2_j
  		assert_equal 15, Triple.new(100,200,300).cycle(5).count
  	end

  	def test_detect_j
  		assert_equal 200 , Triple.new(100,200,300).detect {|item| item /100 == 2}
  	end

  	def test_detect2_j
  		assert_nil Triple.new('Dog', 'Goat', 'Cat').detect{|item| item == "Cattle"}
  	end

  	def test_drop_j
  		assert_equal [300], Triple.new(100,200,300).drop(2)
  	end

  	def test_drop2_j
  		assert_equal [200, 300], Triple.new(100,200,300).drop(1)
  	end

  	def test_drop_while_j
  		assert_equal ["Goat", "Cat"], Triple.new('Dog', 'Goat', 'Cat').drop_while {|animal| animal == "Dog"}
  	end

  	def test_each_cons_j
  		assert_equal 2, Triple.new(100,200,300).each_cons(2).count
  	end

  	def test_each_entry_j
  		assert_equal 3, Triple.new(100,200,300).each_entry.count
  	end

  	def test_each_slice_j
  		assert_equal 2, Triple.new(100,200,300).each_slice(2).count
  	end

  	def test_each_with_object_j
  		assert_equal [5, 10, 20, 30], Triple.new(100,200,300).each_with_object([5]) {|item, arr| arr << item/10}
  	end

  	def test_find_all_j
  		assert_equal [300], Triple.new(100,200,300).find_all {|number| number / 150 == 2}
  	end

  	def test_flat_map_j
  		assert_equal [105, 205, 305], Triple.new(100,200,300).flat_map {|number| number + 5}
  	end

  	def test_flat_map2_j
  		assert_equal [2, 4, 6], Triple.new(100,200,300).flat_map {|number| number / 50}
  	end

  	def test_grep_j
  		assert_equal [300], Triple.new(100,200,300).grep(300)
  	end

  	def test_grep2_j
  		assert_equal [100], Triple.new(100,200,300).grep(100)
  	end

  	def test_grep_v_j
  		assert_equal [100,150], Triple.new(100,200,300).grep_v(100) {|number| number/2}
  	end

  	def test_groupby_j
  		assert_equal 3 , Triple.new(100,200,300).group_by {|number| number/100}.count
  	end

  	def test_inject_j
  		assert_equal 600, Triple.new(100,200,300).inject {|add, number| add + number}
  	end

  	def test_inject_initial_j
  		assert_equal 650, Triple.new(100,200,300).inject(50) {|add, number| add + number}
  	end

  	def test_map_j
  		assert_equal [2,4,6], Triple.new(100,200,300).map {|number| number/50}
  	end

  	def test_map2_j
  		assert_equal [200,400,600], Triple.new(100,200,300).map {|number| number*2}
  	end

  	def test_max_n_j
  		assert_equal [300, 200], Triple.new(100,200,300).max(2)
  	end

  	def test_max_by_j
  		assert_equal 200, Triple.new(100,200,300).max_by {|number| number % 3}
  	end

  	def test_max_by_n_j
  		assert_equal [200, 100], Triple.new(100,200,300).max_by(2) {|number| number % 3}
  	end

  	def test_member_j
  		assert_equal false, Triple.new(100,200,300).member?(400)
  	end

  	def test_member2_j
  		assert_equal true, Triple.new(100,200,300).member?(300)
  	end

  	def test_min_by_j
  		assert_equal 100 , Triple.new(100,200,300).min_by {|item| item%9}
  	end

  	def test_min_by_n_j
  		assert_equal [100, 200] , Triple.new(100,200,300).min_by(2) {|item| item%9}
  	end

  	def test_minmax_j
  		assert_equal [100, 300] , Triple.new(100,200,300).minmax
  	end

  	def test_minmax_by_j
  		assert_equal [300, 200], Triple.new(100,200,300).minmax_by {|item| item %3}
  	end

  	def test_none_j
  		assert_equal false, Triple.new(100,200,300).none? {|number| number%3 == 0}
  	end

  	def test_none2_j
  		assert_equal true, Triple.new(100,200,300).none? {|number| number + 1 == 202}
  	end

  	def test_one_j
  		assert_equal true, Triple.new('Dog', 'Goat', 'Cat').one? {|item| item.length == 4}
  	end

  	def test_reduce_j
  		assert_equal 600, Triple.new(100,200,300).reduce(:+)
  	end

  	def test_reduce2_j
  		assert_equal 6000000, Triple.new(100,200,300).reduce(1, :*)
  	end

  	def test_reduce_n_j
  		assert_equal 750 , Triple.new(100,200,300).reduce(150) {|sum, number| sum + number}
  	end

  	def test_reverse_each_j
  		assert_equal 3, Triple.new(100,200,300).reverse_each.count
  	end

  	def test_sort_by_j
  		assert_equal ["Cat", "Dogs", "Goats"] , Triple.new('Dogs', 'Goats', 'Cat').sort_by {|animal| animal.length}
  	end

  	def test_sum_j
  		assert_equal 600, Triple.new(100,200,300).sum
  	end

  	def test_sum_exp_j
  		assert_equal 6, Triple.new(100,200,300).sum {|number| number/ 100}
  	end

  	def test_sum_exp2_j
  		assert_equal 1200, Triple.new(100,200,300).sum {|number| number* 2}
  	end

  	def test_take_j
  		assert_equal [100, 200], Triple.new(100,200,300).take(2)
  	end

  	def test_take_while_j
  		assert_equal [100], Triple.new(100,200,300).take_while {|number| number < 200}
  	end

  	def test_to_a_j
  		assert_equal [100, 200, 300], Triple.new(100,200,300).to_a
  	end

  	def test_uniq_j
  		assert_equal [100, 200, 300], Triple.new(100,200,300).uniq
  	end

  	def test_zip_j
  		assert_equal [[100, 1],[200, 2], [300,3]], Triple.new(100,200,300).zip([1,2,3])
  	end
end
