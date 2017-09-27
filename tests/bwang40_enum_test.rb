load 'Triple.rb'
# require 'test-unit'
require 'minitest/autorun'

class Triple
  include Enumerable
  def initialize(a,b,c)
    @a = a
    @b = b
    @c = c
    @array=[a,b,c]
  end



#do not necessary!!!
  # def getter
  #   return @array
  # end
  #

  # def each
  #
  #   yield @a
  #   yield @b
  #   yield @c
  #
  # end



end



class Testany < Minitest::Unit::TestCase



def test_all
  assert_equal true,  Triple.new(1,2,3).all?{|x| x.is_a?(Integer)}
  assert_equal false, Triple.new('s', 'd' ,'f' ).all?{|x| x.is_a?(Integer)}
  assert_equal false, Triple.new(nil, nil , nil ).all?{|x| x.is_a?(Integer)}
  assert_equal false, Triple.new(1, nil, 3).all?{|x| x.is_a?(Integer)}
  assert_equal false, Triple.new( 's', nil, 'f').all?{|x| x.is_a?(Integer)}
  assert_equal false, Triple.new( 1, nil, 'd').all?{|x| x.is_a?(Integer)}
  assert_equal false, Triple.new(1, 2, 'g').all?{|x| x.is_a?(Integer)}
end

def test_any?
  assert_equal true, Triple.new(1,2,3).any?{|x| x.is_a?(Integer)}
  assert_equal false,  Triple.new('s', 'd' ,'f' ).any?{|x| x.is_a?(Integer)}
  assert_equal false,  Triple.new(nil, nil , nil ).any?{|x| x.is_a?(Integer)}
  assert_equal true,  Triple.new(1, nil, 3).any?{|x| x.is_a?(Integer)}
  assert_equal false,  Triple.new( 's', nil, 'f').any?{|x| x.is_a?(Integer)}
  assert_equal true,  Triple.new( 1, nil, 'd').any?{|x| x.is_a?(Integer)}
  assert_equal true,  Triple.new(1, 2, 'g').any?{|x| x.is_a?(Integer)}
end



def test_count?
  assert_equal 3, Triple.new(1,2,3).count
  assert_equal 3, Triple.new('s', 'd' ,'f' ).count
  assert_equal 3, Triple.new(nil, nil , nil ).count
  assert_equal 3, Triple.new(1, nil, 3).count
  assert_equal 3, Triple.new( 's', nil, 'f').count
  assert_equal 3, Triple.new( 1, nil, 'd').count
  assert_equal 3, Triple.new(1, 2, 'g').count

end

def test_countitem?
  assert_equal 1, Triple.new(1,2,3).count(1)
  assert_equal 0, Triple.new('s', 'd' ,'f' ).count(1)
  assert_equal 0, Triple.new(nil, nil , nil ).count(1)
  assert_equal 1, Triple.new(1, nil, 3).count(1)
  assert_equal 0, Triple.new( 's', nil, 'f').count(1)
  assert_equal 1, Triple.new( 1, nil, 'd').count(1)
  assert_equal 1, Triple.new(1, 2, 'g').count(1)
end

def test_countblock?
  assert_equal 3, Triple.new(1,2,3).count{|x| x.is_a?(Integer)}
  assert_equal 0, Triple.new('s', 'd' ,'f' ).count{|x| x.is_a?(Integer)}
  assert_equal 0, Triple.new(nil, nil , nil ).count{|x| x.is_a?(Integer)}
  assert_equal 2, Triple.new(1, nil, 3).count{|x| x.is_a?(Integer)}
  assert_equal 0, Triple.new( 's', nil, 'f').count{|x| x.is_a?(Integer)}
  assert_equal 1, Triple.new( 1, nil, 'd').count{|x| x.is_a?(Integer)}
  assert_equal 2, Triple.new(1, 2, 'g').count{|x| x.is_a?(Integer)}

end

def test_limitcircle?
  arr1 = Array.new
  Triple.new(1,2,3).cycle(2){|x| arr1 << x}
  assert_equal [1,2,3,1,2,3], arr1

  arr2 = Array.new
  Triple.new('s', 'd' ,'f' ).cycle(2){|x| arr2<< x}
  assert_equal ['s','d','f','s','d','f'], arr2

  arr3 = Array.new
  Triple.new(nil, nil , nil ).cycle(2){|x| arr3<< x}
  assert_equal [nil,nil,nil,nil,nil,nil], arr3

  arr4 = Array.new
  Triple.new(1, nil, 3).cycle(2){|x| arr4<< x}
  assert_equal [1, nil,3,1,nil,3], arr4

  arr5 = Array.new
  Triple.new( 's', nil, 'f').cycle(2){|x| arr5<< x}
  assert_equal ['s',nil,'f','s',nil,'f'], arr5

  arr6 = Array.new
  Triple.new( 1, nil, 'd').cycle(2){|x| arr6<< x}
  assert_equal [1,nil,'d',1,nil,'d'], arr6

  arr7 = Array.new
  Triple.new(1, 2, 'g').cycle(2){|x| arr7<<x}
  assert_equal [1,2,'g',1,2,'g'], arr7

end

def test_detectblock?
  assert_equal 1, Triple.new(1,2,3).detect{|x| x.is_a?(Integer)}
  assert_equal nil, Triple.new('s', 'd' ,'f' ).detect{|x| x.is_a?(Integer)}
  assert_equal nil, Triple.new(nil, nil , nil ).detect{|x| x.is_a?(Integer)}
  assert_equal 1, Triple.new(1, nil, 3).detect{|x| x.is_a?(Integer)}
  assert_equal nil, Triple.new( 's', nil, 'f').detect{|x| x.is_a?(Integer)}
  assert_equal 1, Triple.new( 1, nil, 'd').detect{|x| x.is_a?(Integer)}
  assert_equal 1, Triple.new(1, 2, 'g').detect{|x| x.is_a?(Integer)}


end


def test_drop?


  assert_equal [3], Triple.new(1,2,3).drop(2)
  assert_equal ['f'], Triple.new('s', 'd' ,'f' ).drop(2)
  assert_equal [nil], Triple.new(nil, nil , nil ).drop(2)
  assert_equal [3], Triple.new(1, nil, 3).drop(2)
  assert_equal ['f'], Triple.new( 's', nil, 'f').drop(2)
  assert_equal ['d'], Triple.new( 1, nil, 'd').drop(2)
  assert_equal ['g'], Triple.new(1, 2, 'g').drop(2)

end


def test_dropwhile?


  arr1 = Array.new
  arr1<<Triple.new(1,2,3).drop_while{|i| i.is_a?(Integer)}
  assert_equal [[]], arr1


  arr2 = Array.new
  arr2<<Triple.new('s', 'd' ,'f' ).drop_while{|i| i.is_a?(Integer)}

  assert_equal [['s','d','f']], arr2

  arr3 = Array.new
  arr3<<Triple.new(nil, nil , nil ).drop_while{|i| i.is_a?(Integer)}
  assert_equal [[nil,nil,nil]], arr3


  arr4 = Array.new
  arr4<<Triple.new(1, nil, 3).drop_while{|i| i.is_a?(Integer)}
  assert_equal [[nil,3]], arr4

  arr5 = Array.new
  arr5<<Triple.new( 's', nil, 'f').drop_while{|i| i.is_a?(Integer)}
  assert_equal [['s',nil,'f']], arr5


  arr6 = Array.new
  arr6<<Triple.new( 1, nil, 'd').drop_while{|i| i.is_a?(Integer)}
  assert_equal [[nil,'d']], arr6

  arr7 = Array.new
  arr7<<Triple.new(1, 2, 'g').drop_while{|i| i.is_a?(Integer)}
  assert_equal [['g']], arr7

end


def test_dpwhile

  assert_equal [1], Triple.new(1,2,3).drop_while.to_a
  assert_equal ['s'], Triple.new('s', 'd' ,'f' ).drop_while.to_a
  assert_equal [nil], Triple.new(nil, nil , nil ).drop_while.to_a
  assert_equal [1], Triple.new(1, nil, 3).drop_while.to_a
  assert_equal ['s'], Triple.new( 's', nil, 'f').drop_while.to_a
  assert_equal [1], Triple.new( 1, nil, 'd').drop_while.to_a
  assert_equal [1], Triple.new(1, 2, 'g').drop_while.to_a
end


def test_eachcon

  arr1 = Array.new
  Triple.new(1,2,3).each_cons(2){|a| arr1<< a}
  assert_equal [[1,2],[2,3]], arr1

  arr2 = Array.new
  Triple.new('s', 'd' ,'f' ).each_cons(2){|a| arr2<<a}
  assert_equal [['s','d'],['d','f']], arr2
  # assert_equal [[1,2][2,3]], arr1
end

def test_eachc
  arr1 =Array.new
  arr1<<Triple.new(1,2,3).each_cons(2).to_a
  assert_equal [[[1,2],[2,3]]],arr1

  arr2= Array.new
  arr2<<Triple.new('s', 'd' ,'f' ).each_cons(2).to_a
  assert_equal [[['s','d'],['d','f']]],arr2
end


def test_entry
  assert_equal [1,2,3], Triple.new(1,2,3).each_entry.to_a
  assert_equal ['s','d','f'], Triple.new('s', 'd' ,'f' ).each_entry.to_a

end

def test_entry2

  # assert_equal [1,[1,2],nil], Easy.new.each_entry{|o| p o}.to_a
  #puts Easy.new.each_entry{|o| p o}
end



def test_slice
  arr= Array.new
  Triple.new(1,2,3).each_slice(2){|a| arr<<a}
  assert_equal [[1,2],[3]], arr

end

def test_slice1
  arr=Array.new
  arr<<Triple.new(1,2,3).each_slice(2).to_a
  assert_equal [[[1,2],[3]]],arr

end

def test_withindex
  hash = Hash.new
  assert_equal ['s','d','f'], Triple.new('s', 'd' ,'f' ).each_with_index{|item, index| hash[item]=index}.to_a

end


def test_withindex2
  hash = Hash.new
  assert_equal [['s',0],['d',1],['f',2]], Triple.new('s', 'd' ,'f' ).each_with_index.to_a
end



def test_withobj
  arr = Array.new
  arr<<Triple.new(1,2,3).each_with_object([]){|i,a| a<<i*2}
  assert_equal [[2,4,6]],arr
end

def test_withobj1
  arr = Array.new
  arr<<Triple.new(1,2,3).each_with_object([]).to_a

  #puts "wwq"
  #puts arr
  assert_equal [[[1, []],[2, []],[3, []]]],arr

end


def test_entries
  assert_equal [1,2,3], Triple.new(1,2,3).to_a
end

def test_find
  assert_equal 1,Triple.new(1,2,3).find{|i| i.is_a?(Integer)}
end

def test_find1

  assert_equal [1,2,3],Triple.new(1,2,3).find.to_a
end


def test_findall
  assert_equal [1,2,3], Triple.new(1,2,3).find_all{|i| i.is_a?(Integer)}
end


def test_findall1
  assert_equal [1,2,3], Triple.new(1,2,3).find_all.to_a
end

def test_findindex
  assert_equal 0, Triple.new(1,2,3).find_index{|i| i.is_a?(Integer)}
end

def test_findindex1
  assert_equal 1, Triple.new('s', 'd' ,'f' ).find_index('d')
end

def test_findindex2

  assert_equal [1,2,3],Triple.new(1,2,3).find_index.to_a
end


def test_first
  assert_equal ['s'], Triple.new('s', 'd' ,'f' ).first(1)
end



def test_first1
  assert_equal 1, Triple.new(1,2,3).first
end

def test_map
  assert_equal [1,-1,2,-2,3,-3], Triple.new(1,2,3).flat_map{|e| [e,-e]}
end

def test_grep
  assert_equal Triple.new(1,2,3).grep(1),[1]
end

def test_grep_v
  assert_equal Triple.new(1,2,3).grep_v(1),[2,3]
end

def test_group_by
  assert_equal Triple.new(1,2,3).group_by{|x|x%2==0},{false=>[1, 3], true=>[2]}
end

def test_include?
  assert_equal Triple.new(1,2,3).include?(1),true
end

def test_inject

  assert_equal Triple.new(1,2,3).inject{|sum,n|sum+n},6
end

def test_lazy

  assert_equal Triple.new(1,2,3).lazy.to_a,[1,2,3]
end

def test_map
  assert_equal Triple.new(1,2,3).map{|x|x*2},[2,4,6]
end

def test_max
  assert_equal Triple.new(1,2,3).max,3
end

def test_maxby
  assert_equal Triple.new(1,2,3).max_by{|x|x},3
end

def test_member?
  assert_equal Triple.new(1,2,3).member?(1),true
end

def test_min
  assert_equal Triple.new(1,2,3).min{|x|x},1
end

def test_minby
  assert_equal Triple.new(1,2,3).min_by{|x|x},1
end

def test_minmax
  assert_equal Triple.new(1,2,3).minmax,[1,3]
end

def test_minmax_by
  assert_equal Triple.new(1,2,3).minmax_by{|x|x},[1,3]
end

def test_none?
  assert_equal Triple.new(1,2,3).none?{|x|x<1},true
end

def test_one?
  assert_equal Triple.new(1,2,3).one?{|x|x>1},false
end

def test_partition
  assert_equal Triple.new(1,2,3).partition{|x|x>1},[[2,3],[1]]
end

def test_reduce
  assert_equal Triple.new(1,2,3).reduce(:+),6
end

def test_reject
  assert_equal Triple.new(1,2,3).reject{|x|x%2==0},[1,3]
end

def test_reserve
  assert_equal Triple.new(1,2,3).reverse_each.to_a,[3,2,1]
end

def test_select
  assert_equal Triple.new(1,2,3).select{|x|x%2==0},[2]
end

def test_slice_after
  assert_equal Triple.new(1,2,3).slice_after(1).to_a,[[1],[2,3]]
end

def test_slice_before

  assert_equal Triple.new(1,2,3).slice_before(1).to_a,[[1,2,3]]
end

def test_slice_when
  #puts "here??"
  #puts Triple.new(1,2,3).slice_when{|x,y|y=x+1}
  assert_equal Triple.new(1,2,3).slice_when{|x|x<2}.to_a,[[1],[2,3]]
end

def test_sort
  assert_equal Triple.new(1,2,3).sort,[1,2,3]
end

def test_sortby
  assert_equal Triple.new(1,2,3).sort_by{|x|x},[1,2,3]
end

def test_sum
  assert_equal Triple.new(1,2,3).sum,6
end

def test_take
  assert_equal Triple.new(1,2,3).take(1),[1]
end

def test_to_a
  assert_equal Triple.new(1,2,3).to_a,[1,2,3]
end


# # bad test!!
# def test_to_h
#   puts  Triple.new(1,2,3).each_with_index.to_h.to_s
#   assert_equal Triple.new(1,2,3).each_with_index.to_h.to_s,{1=>0, 2=>1, 3=>2}
# end



#After fix
  def test_to_h
    assert_equal({0=>2, 1=>3, 2=>4}, Triple.new([0,2],[1,3],[2,4]).to_h)
  end






def test_unq
  assert_equal Triple.new(1,2,3).uniq,[1,2,3]
end

def test_zip
  a=[0,0,0]
  assert_equal Triple.new(1,2,3).zip(a).to_a,[[1,0],[2,0],[3,0]]
end

def test_detect?
  assert_equal 2, Triple.new(1,2,3).detect{|x|x%2==0}
end

def test_chunk
  assert_equal([[false, [1]], [true, [2]], [false, [3]]],Triple.new(1,2,3).chunk{|i| i.even?}.to_a)
end


end





















