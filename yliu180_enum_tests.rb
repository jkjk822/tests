# File: yliu180_enum_tests.rb

#require_relative "Liu_enum"
#require_relative "Triple"
require "test/unit"

#include LiuEnumerable        
    class Enum < Test::Unit::TestCase

        def test_simple

            @items1 = Triple.new(1,2,3)
            @items2 = Triple.new("1","2","3")
            @items3 = Triple.new(nil,nil,nil)


	      #test all?
            assert_equal(true, @items1.all?)

            assert_equal(false, @items3.all?)


            #test any?
            assert_equal(true, @items1.any?)

            assert_equal(false, @items3.any?)


            #test chunk
            assert_equal [[true, [1, 2, 3]]], @items1.chunk { |e| e % 1 == 0 }.to_a


            #test collect
            a1 = @items1.collect {|num| num * 2}
            assert_equal([2,4,6], a1)

            a2 = @items2.collect {|num| num * 2}
            assert_equal(["11","22","33"], a2)

            a3 = @items3.collect {|num| num}
            assert_equal([nil,nil,nil], a3)


            #test collect_concat
            b1 = @items1.collect_concat {|num| [num, -num]}
            assert_equal([1,-1,2,-2,3,-3], b1)

            b2 = @items2.collect_concat {|num| [num]}
            assert_equal(["1","2","3"], b2)

            b3 = @items3.collect_concat {|num| [num]}
            assert_equal([nil,nil,nil], b3)


            #test count
            assert_equal(0, @items1.count(0))

            assert_equal(0, @items2.count(0))

            assert_equal(0, @items3.count(0))


            #test cycle  
            c = @items1.cycle(2) {|num| puts num}
            assert_equal(nil, c)


            #test detect
            d1 = @items1.detect {|num| num % 2 == 1}
            assert_equal(1, d1)

            d2 = @items2.detect {|num| num}
            assert_equal("1", d2)

            d3 = @items3.detect {|num| num}
            assert_equal(nil, d3)


            #test drop
            assert_equal([1,2,3], @items1.drop(0))

            assert_equal(["1","2","3"], @items2.drop(0))

            assert_equal([nil,nil,nil], @items3.drop(0))


            #test drop_while
            e1 = @items1.drop_while {|num| num == 4}
            assert_equal([1,2,3], e1)

            e2 = @items2.drop_while {|num| num}
            assert_equal([], e2)

            e3 = @items3.drop_while {|num| num}
            assert_equal([nil,nil,nil], e3)


            #test each_cons
            f1 = @items1.each_cons(3) {|num| puts num}
            assert_equal(nil, f1)

            f2 = @items2.each_cons(3) {|num| puts num}
            assert_equal(nil, f2)

            f3 = @items3.each_cons(3) {|num| puts num}
            assert_equal(nil, f3)


            #test each_slice
            ff1 = @items1.each_slice(3) {|num| puts num}
            assert_equal(nil, ff1)

            ff2 = @items2.each_slice(3) {|num| puts num}
            assert_equal(nil, ff2)

            ff3 = @items3.each_slice(3) {|num| puts num}
            assert_equal(nil, ff3)


            #test entries
            assert_equal([1,2,3], @items1.entries)

            assert_equal(["1","2","3"], @items2.entries)

            assert_equal([nil,nil,nil], @items3.entries)


            #test find
            g1 = @items1.find {|num| num % 2 == 1}
            assert_equal(1, g1)

            g2 = @items2.find {|num| num}
            assert_equal("1", g2)

            g3 = @items3.find {|num| num}
            assert_equal(nil, g3)


            #test find_all
            gg1 = @items1.find_all {|num| num % 2 == 1}
            assert_equal([1,3], gg1)

            gg2 = @items2.find_all {|num| num}
            assert_equal(["1","2","3"], gg2)

            gg3 = @items3.find_all {|num| num}
            assert_equal([], gg3)


            #test first
            assert_equal([1,2], @items1.first(2))

            assert_equal(["1","2"], @items2.first(2))

            assert_equal([nil,nil], @items3.first(2))


            #test flat_map
            h1 = @items1.flat_map {|num| [num, -num]}
            assert_equal([1,-1,2,-2,3,-3], h1)

            h2 = @items2.flat_map {|num| [num]}
            assert_equal(["1","2","3"], h2)

            h3 = @items3.flat_map {|num| [num]}
            assert_equal([nil,nil,nil], h3)


            #test grep
            assert_equal([1,2], @items1.grep(1..2))

            assert_equal([], @items2.grep(1..2))

            assert_equal([], @items3.grep(1..2))


            #test grep_v
            assert_equal([3], @items1.grep_v(1..2))

            assert_equal(["1","2","3"], @items2.grep_v(1..2))

            assert_equal([nil,nil,nil], @items3.grep_v(1..2))


            #test include?
            assert_equal(false, @items1.include?(8))

            assert_equal(false, @items2.include?("4"))

            assert_equal(false, @items3.include?(1))


            #test inject
            assert_equal(6, @items1.inject(:+))


            #test map
            l1 = @items1.map {|num| num * 2}
            assert_equal([2,4,6], l1)

            l2 = @items2.map {|num| num}
            assert_equal(["1","2","3"], l2)

            l3 = @items3.map {|num| num}
            assert_equal([nil,nil,nil], l3)


            #test max
            assert_equal(3, @items1.max)

            m = @items1.max {|num, compare| num * 3 <=> compare * 3}
            assert_equal(3, m)


            #test max_by
            n = @items1.max_by {|num| num * 0.2}
            assert_equal(3, n)


            #test member?
            assert_equal(false, @items1.member?(8))

            assert_equal(false, @items2.member?("4"))

            assert_equal(false, @items3.member?(1))


            #test min
            assert_equal(1, @items1.min)

            o = @items1.min {|num, compare| num * 3 <=> compare * 3}
            assert_equal(1, o)


            #test min_by
            p = @items1.min_by {|num| num * 2}
            assert_equal(1, p)


            #test minmax
            assert_equal([1,3], @items1.minmax)

            q = @items1.minmax {|num, compare| num * 3 <=> compare * 3}
            assert_equal([1,3], q)


            #test minmax_by
            r = @items1.minmax_by {|num| num * 2}
            assert_equal([1,3], r)


            #test none?
            assert_equal(false, @items1.none?)

            assert_equal(false, @items2.none?)

            assert_equal(true, @items3.none?)


            #test one?
            assert_equal(false, @items1.one?)

            assert_equal(false, @items2.one?)

            assert_equal(false, @items3.one?)


            #test partition
            s1 = @items1.partition {|num| num.even?}
            assert_equal([[2],[1,3]], s1)

            s2 = @items2.partition {|num| num}
            assert_equal([["1","2","3"],[]], s2)

            s3 = @items3.partition {|num| num}
            assert_equal([[],[nil,nil,nil]], s3)


            #test reduce
            assert_equal(6, @items1.reduce(:+))


            #test reject
            ss1 = @items1.reject {|num| num.even?}
            assert_equal([1,3], ss1)

            ss2 = @items2.reject {|num| num}
            assert_equal([], ss2)

            ss3 = @items3.reject {|num| num}
            assert_equal([nil,nil,nil], ss3)


            #test select
            tt1 = @items1.select {|num| num % 2 == 1}
            assert_equal([1,3], tt1)

            tt2 = @items2.select {|num| num}
            assert_equal(["1","2","3"], tt2)

            tt3 = @items3.select {|num| num != nil}
            assert_equal([], tt3)


            #test sort
            assert_equal([1,2,3], @items1.sort)

            assert_equal(["1","2","3"], @items2.sort)


            #test sort_by
            t1 = @items1.sort_by {|num| num % 3}   
            assert_equal([3,1,2], t1)

            t2 = @items2.sort_by {|num| num}   
            assert_equal(["1","2","3"], t2)

            t3 = @items3.sort_by {|num| num}   
            assert_equal([nil,nil,nil], t3)


            #test sum
            assert_equal(6, @items1.sum)


            #test sum
            u1 = @items1.sum {|num| num * 2}
            assert_equal(12, u1)


            #test take
            assert_equal([1,2], @items1.take(2))

            assert_equal(["1","2"], @items2.take(2))

            assert_equal([nil,nil], @items3.take(2))


            #test take_while
            v1 = @items1.take_while {|num| num % 2 == 1}
            assert_equal([1], v1)


            #test to_a
            assert_equal([1,2,3], @items1.to_a)

            assert_equal(["1","2","3"], @items2.to_a)

            assert_equal([nil,nil,nil], @items3.to_a)


            #test uniq
            assert_equal([1,2,3], @items1.uniq)

            assert_equal(["1","2","3"], @items2.uniq)


            #test uniq
            w1 = @items1.uniq {|num| num * 2}
            assert_equal([1,2,3], w1)

            w2 = @items2.uniq {|num| num}
            assert_equal(["1","2","3"], w2)


            #test zip
            assert_equal([[1,5],[2,6],[3,7]], @items1.zip([5,6,7]))

            assert_equal([["1",5],["2",6],["3",7]], @items2.zip([5,6,7]))

            assert_equal([[nil,5],[nil,6],[nil,7]], @items3.zip([5,6,7]))

            zz1 = @items1.zip([])
            assert_equal([[1, nil], [2, nil], [3, nil]], zz1)

            zz2 = @items2.zip([])
            assert_equal([["1", nil], ["2", nil], ["3", nil]], zz2)
            
            zz3 = @items3.zip([])
            assert_equal([[nil, nil], [nil, nil], [nil, nil]], zz3)

    end
#end

