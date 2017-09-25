require 'minitest/autorun'


class JohnstonEnumerableTests < Minitest::Unit::TestCase

	def setup
		# Triple.new(1,2,3) = Triple.new(1,2,3)
		# Triple.new(2,4,5) = Triple.new(2,4,5)
		# Triple.new(3,3,7) = Triple.new(3,3,7)
		# Triple.new("Hunter","Sutherland","Johnston") = Triple.new("Hunter","Sutherland","Johnston")
	end

	def test_hello
		# assert_equal("Hello World",Triple.new(1,2,3).hello)
	end
	
	#all?
	def test_all
		assert_equal(true, Triple.new(1,2,3).all?{|i| i<5})
		assert_equal(true, Triple.new("Hunter","Sutherland","Johnston").all?{|i| i.length > 3})
	end

	#any?
	def test_any
		assert_equal(true, Triple.new(1,2,3).any?{|i| i>2})
		assert_equal(true, Triple.new("Hunter","Sutherland","Johnston").any?{|i| i.length==6})
	end

	#chunk
	def test_chunk
		assert_equal([[false, [1]], [true, [2]], [false, [3]]],Triple.new(1,2,3).chunk{|i| i.even?}.to_a)
	end

	# chunk_while
	def test_chunk_while
		assert_equal([[2, 4], [5]], Triple.new(2,4,5).chunk_while{|i,j| i%2==0 && j%2==0}.to_a)
	end

	#collect
	def test_collect
		assert_equal([1,4,9],Triple.new(1,2,3).collect{|i| i*i})
	end

	#collect_concat
	def test_collect_concat
		assert_equal([1,2,3,2,3,4,3,4,5], Triple.new(1,2,3).collect_concat{|i| [i,i+1,i+2]})
	end

	#count
	def test_count
		assert_equal(3,Triple.new(1,2,3).count)
		assert_equal(2,Triple.new(3,3,7).count(3))
		assert_equal(2,Triple.new(1,2,3).count{|i| i<=2})
	end

	#cycle
	def test_cycle
		sum = 0
		assert_equal(nil,Triple.new(1,2,3).cycle(2){|i| sum+=i})
		assert_equal(12,sum)
	end

	#detect
	def test_detect
		# def hi
		# 	return "hi"
		# end
		assert_equal(2,Triple.new(1,2,3).detect{|i| i>1})
		assert_equal("Sutherland",Triple.new("Hunter","Sutherland","Johnston").detect{|i| i.length>6})
		assert_equal("hi",Triple.new(1,2,3).detect(lambda{"hi"}){|i| i==60})
	end

	#drop
	def test_drop
		assert_equal([2,3],Triple.new(1,2,3).drop(1))
		assert_equal([],Triple.new(1,2,3).drop(3))
	end

	#drop_while
	def test_drop_while
		assert_equal([2,3], Triple.new(1,2,3).drop_while{|i| i%2==1})
	end

	#each_cons
	def test_each_cons
		total = []
		assert_equal(nil,Triple.new(1,2,3).each_cons(2){|i| total << i})
		assert_equal([[1,2],[2,3]],total)
	end

	#each_entry
	def test_each_entry
		r = []
		Triple.new(1,2,3).each_entry{|i| r<<i}
		assert_equal([1,2,3],r)
	end

	#each_slice
	def test_each_slice
		total = []
		assert_equal(nil,Triple.new(1,2,3).each_slice(2){|i| total << i})
		assert_equal([[1,2],[3]],total)
	end

	#each_with_index
	def test_each_with_index
		total = []
		Triple.new(1,2,3).each_with_index{|i,index| total << i+=index}
		assert_equal([1,3,5],total)
	end

	#each_with_object
	def test_each_with_object
		assert_equal([1,4,9],Triple.new(1,2,3).each_with_object([]){|i,ob| ob << i*i})
	end

	#entries
	def test_entries
		assert_equal([1,2,3],Triple.new(1,2,3).entries)
	end

	#find
	def test_find
		assert_equal(2,Triple.new(1,2,3).find{|i| i>1})
	end

	#find_all
	def test_find_all
		assert_equal([2,3],Triple.new(1,2,3).find_all{|i| i>1})
	end

	#find_index
	def test_find_index
		assert_equal(2,Triple.new(1,2,3).find_index(3))
		assert_equal(1,Triple.new(1,2,3).find_index{|i| i==2})
	end

	#first
	def test_first
		assert_equal(1,Triple.new(1,2,3).first)
		assert_equal([1,2],Triple.new(1,2,3).first(2))
	end

	#flat_map
	def test_flat_map
		assert_equal([1,2,3,2,3,4,3,4,5],Triple.new(1,2,3).flat_map{|i| [i,i+1,i+2]})
	end

	#grep
	def test_grep
		assert_equal([2,3], Triple.new(1,2,3).grep(2..3))
		assert_equal([4,9],Triple.new(1,2,3).grep(2..3){|i| i*i})
	end

	#grep_v
	def test_grep_v
		assert_equal([1],Triple.new(1,2,3).grep_v(2..3))
		assert_equal([2],Triple.new(1,2,3).grep_v(2..3){|i| i+1})
	end

	#group_by
	def test_group_by
		assert_equal({true=>[2,3],false=>[1]},Triple.new(1,2,3).group_by{|i| i>1})
	end

	#include?
	def test_include
		assert_equal(true,Triple.new(1,2,3).include?(2))
	end

	# #inject
	def test_inject
		assert_equal(11,Triple.new(1,2,3).inject(5,:+))
		assert_equal(6,Triple.new(1,2,3).inject(:+))
		assert_equal(11,Triple.new(1,2,3).inject(5){|sum,i| sum+i})
		assert_equal(6,Triple.new(1,2,3).inject{|sum,i| sum+i})
	end

	# #lazy
	# def test_lazy # TODO this one is hard to test
	# 	# output = Triple.new(1,2,3).lazy{|i| i>1}
	# 	# p output
	# end

	#map
	def test_map
		assert_equal([1,4,9],Triple.new(1,2,3).map{|i| i*i})
	end

	#max
	def test_max
		assert_equal(3,Triple.new(1,2,3).max)
		# assert_equal(3,(1..3).max{|i,j| i<=>j})
		assert_equal(3,Triple.new(1,2,3).max{|i,j| i <=> j})
		# assert_equal(1,(1..3).max{|i,j| i%2 <=> j%2})
		# assert_equal(3,[2,3,1].max{|i,j| i%2 <=> j%2})
		assert_equal([3,2],Triple.new(1,2,3).max(2))
		assert_equal([3,2],Triple.new(1,2,3).max(2){|i,j| i <=> j})
	end

	#max_by
	def test_max_by
		assert_equal(3,Triple.new(1,2,3).max_by{|i| i})
		assert_equal([1,2],Triple.new(1,2,3).max_by(2){|i| -i})
	end

	#member?
	def test_member
		assert_equal(true,Triple.new(1,2,3).member?(3))
		assert_equal(false,Triple.new(1,2,3).member?(4))
	end

	#min
	def test_min
		assert_equal(1,Triple.new(1,2,3).min)
		assert_equal(1,Triple.new(1,2,3).min{|i,j| i <=> j})
		assert_equal([1,2],Triple.new(1,2,3).min(2))
		assert_equal([1,2],Triple.new(1,2,3).min(2){|i,j| i <=> j})
	end

	#min_by
	def test_min_by
		assert_equal(3,Triple.new(1,2,3).min_by{|i| -i})
		assert_equal([1,2],Triple.new(1,2,3).min_by(2){|i| i})
	end

	#minmax
	def test_minmax
		assert_equal([1,3],Triple.new(1,2,3).minmax)
		assert_equal([1,3],Triple.new(1,2,3).minmax{|a,b| a<=>b})
	end

	#minmax_by
	def test_minmax_by
		assert_equal([3,1], Triple.new(1,2,3).minmax_by{|i| -i})
	end

	#none?
	def test_none
		assert_equal(true,Triple.new(1,2,3).none?{|i| i<1})
	end

	#one?
	def test_one
		assert_equal(true, Triple.new(1,2,3).one?{|i| i<=1})
	end

	#partition
	def test_partition
		assert_equal([[2,3],[1]],Triple.new(1,2,3).partition{|i| i>1})
	end

	#reduce
	def test_reduce
		assert_equal(11,Triple.new(1,2,3).reduce(5,:+))
		assert_equal(6,(1..3).reduce(:+))
		assert_equal(6,Triple.new(1,2,3).reduce(:+))
		assert_equal(11,Triple.new(1,2,3).reduce(5){|sum,i| sum+i}) # should it be sum += i?
		assert_equal(6,Triple.new(1,2,3).reduce{|sum,i| sum+i})
	end

	#reject
	def test_reject
		assert_equal([1,2], Triple.new(1,2,3).reject{|i| i>2})
	end

	# #reverse_each
	def test_reverse_each
		x2 = []
		Triple.new(1,2,3).reverse_each{|i| x2 << i*i}
		assert_equal([9,4,1],x2)
	end

	#select
	def test_select
		assert_equal([2,3], Triple.new(1,2,3).select{|i| i>1})
	end

	#slice_after
	def test_slice_after
		assert_equal([[1,2],[3]], Triple.new(1,2,3).slice_after{|i| i>1}.to_a)
		assert_equal([[2,4],[5]],Triple.new(2,4,5).slice_after(4..5).to_a)
	end

	#slice_before
	def test_slice_before
		assert_equal([[1,2],[3]],Triple.new(1,2,3).slice_before{|i| i==1 || i==3}.to_a)
		assert_equal([[3],[3,7]],Triple.new(3,3,7).slice_before(3).to_a)
		# assert_equal([],[1,2,3,4,5,3,6,7].slice_before(3).to_a)
	end

	#slice_when
	def test_slice_when
		assert_equal([[1],[2],[3]],Triple.new(1,2,3).slice_when{|i,j| j==i+1}.to_a)
		assert_equal([[3,3],[7]],Triple.new(3,3,7).slice_when{|i,j| j!=i}.to_a)
	end

	#sort
	def test_sort
		assert_equal([1,2,3],Triple.new(1,2,3).sort)
		assert_equal([3,2,1],Triple.new(1,2,3).sort{|a,b| b-a})
		assert_equal([1,2,3],Triple.new(1,2,3).sort{|a,b| a<=>b})
		assert_equal([3,3,7],Triple.new(3,3,7).sort)
		assert_equal([7,3,3],Triple.new(3,3,7).sort{|a,b| b-a})
	end

	#sort_by
	def test_sort_by
		assert_equal([2,1,3],Triple.new(1,2,3).sort_by{|i| i%2})
	end

	#sum
	def test_sum
		assert_equal(11,Triple.new(1,2,3).sum(5))
		assert_equal(12,Triple.new(1,2,3).sum{|i| i*2})
	end

	#take
	def test_take
		assert_equal([1,2],Triple.new(1,2,3).take(2))
	end

	#take_while
	def test_take_while
		assert_equal([1],Triple.new(1,2,3).take_while{|i| i==1})
	end

	#to_a
	def test_to_a
		assert_equal([1,2,3],Triple.new(1,2,3).to_a)
	end

	#to_h
	def test_to_h
		assert_equal({"apples"=>2, "banannas"=>5, "blueberries"=>30}, Triple.new(["apples",2],["banannas",5],["blueberries",30]).to_h)
	end

	#uniq
	def test_uniq
		assert_equal([1,2,3],Triple.new(1,2,3).uniq)
		assert_equal([3,7],Triple.new(3,3,7).uniq)
		assert_equal([1,2,3],Triple.new(1,2,3).uniq{|i| i})
	end

	#zip
	def test_zip
		assert_equal([[1,3],[2,3],[3,7]],Triple.new(1,2,3).zip(Triple.new(3,3,7)))
		assert_equal([[1,3,2],[2,3,4],[3,7,5]],Triple.new(1,2,3).zip(Triple.new(3,3,7), Triple.new(2,4,5)))
		assert_equal(nil,Triple.new(1,2,3).zip{|i| i})

		c=[]
		assert_equal(nil,Triple.new(1,2,3).zip(Triple.new(2,4,5)){ |x, y| c << x + y })
		assert_equal([3,6,8],c)
	end


end





















