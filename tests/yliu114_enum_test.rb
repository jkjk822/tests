require_relative "../liu_enum/triple"
#require "test/unit"
require "minitest/autorun"

#class TestTriple < Test::Unit::TestCase
class TestTriple < Minitest::Test 

  def test_all?
    assert_equal(true, Triple.new("I","love","Lucinda").all?{|obj| obj.is_a?(String)} )
    assert_equal(false, Triple.new("I","love","Lucinda").all?{|obj| obj.is_a?(Fixnum)} )
    assert_equal(true, Triple.new("I","love","Lucinda").all?)
    assert_equal(true, Triple.new("I","love","Lucinda").all?{|obj| obj.length >= 1} )
  end

  def test_any?
    assert_equal(true, Triple.new("I","love","Lucinda").any?{|obj| obj.is_a?(String)} )
    assert_equal(true, Triple.new("I","love","Lucinda").any?{|obj| obj.length == 1} )
    assert_equal(false, Triple.new("I","love","Lucinda").any?{|obj| obj.is_a?(Fixnum)} )
    assert_equal(false, Triple.new("I","love","Lucinda").any?{|obj| obj.length == 5} )
    assert_equal(true, Triple.new("I","love","Lucinda").any? )
  end


  def test_chunk
    assert_equal([true,["I","love"]],
    Triple.new("I","love","Lucinda").chunk{|e| e.length <= 4}.first)
    assert_equal([false,["Lucinda"]],
    Triple.new("I","love","Lucinda").chunk{|e| e.length <= 4}.to_a.last)
  end

  def test_chunk_while
    arr = Triple.new("I","love","Lucinda").chunk_while{|before,after| before.length < after.length}
    assert_equal([["I","love","Lucinda"]],arr.to_a)
    arr = Triple.new("I","love","Lucinda").chunk_while{|before,after| before.length > after.length}
    assert_equal([["I"],["love"],["Lucinda"]],arr.to_a)
  end

  def test_collect
    arr = Triple.new("I","love","Lucinda").collect{|c| c << "!"}
    assert_equal(arr,["I!","love!","Lucinda!"])
  #  enu = Triple.new("I","love","Lucinda").collect
  #  assert_equal(true,enu.is_a?(Enumerator))
  end

  def test_map
    arr = Triple.new("I","love","Lucinda").map{|c| c << "!"}
    assert_equal(arr,["I!","love!","Lucinda!"])
  #  enu = Triple.new("I","love","Lucinda").map
  #  assert_equal(true,enu.is_a?(Enumerator))
  end

  def test_collect_concat
    arr = Triple.new("I","love","Lucinda").collect_concat{|c| [c,"!"]}
    assert_equal(arr,["I","!","love","!","Lucinda","!"])
  #  enu = Triple.new("I","love","Lucinda").collect_concat
  #  assert_equal(true,enu.is_a?(Enumerator))
  end

  def test_flat_map
    arr = Triple.new("I","love","Lucinda").flat_map{|c| [c,"!"]}
    assert_equal(arr,["I","!","love","!","Lucinda","!"])
  #  enu = Triple.new("I","love","Lucinda").flat_map
  #  assert_equal(true,enu.is_a?(Enumerator))
  end

  def test_count
    assert_equal(3,Triple.new("I","love","Lucinda").count)
    assert_equal(1,Triple.new("I","love","Lucinda").count("I"))
    assert_equal(1,Triple.new("I","love","Lucinda").count("love"))
    assert_equal(0,Triple.new("I","love","Lucinda").count("I."))
    assert_equal(1,Triple.new("I","love","Lucinda").count{|e| e.length == 4})
  end

  def test_cycle
    #https://stackoverflow.com/questions/14987362/how-can-i-capture-stdout-to-a-string
    std = StringIO.new
    $stdout = std

    assert_equal(nil,Triple.new("I","love","Lucinda").cycle(3){|e| p e})
    assert_equal("\"I\"\n\"love\"\n\"Lucinda\"\n\"I\"\n\"love\"\n\"Lucinda\"\n\"I\"\n\"love\"\n\"Lucinda\"\n", $stdout.string)
  #  assert_equal(true,Triple.new("I","love","Lucinda").cycle(3).is_a?(Enumerator))
  end

    def test_detect
      assert_equal("love",Triple.new("I","love","Lucinda").detect(ifnone=nil){|e| e.length == 4})
      assert_equal("I",Triple.new("I","love","Lucinda").detect(ifnone=nil){|e| e.length == 1})
      assert_equal(nil,Triple.new("I","love","Lucinda").detect(ifnone=nil){|e| e.length == 3})
      assert_equal(nil,Triple.new("I","love","Lucinda").detect{|e| e.length == 3})
  #    assert_equal(true,Triple.new("I","love","Lucinda").detect.is_a?(Enumerator))
    end

    def test_drop
      assert_equal(["Lucinda"],Triple.new("I","love","Lucinda").drop(2))
      assert_equal(["love","Lucinda"],Triple.new("I","love","Lucinda").drop(1))
    end

    def test_drop_while
      assert_equal(["Lucinda"],Triple.new("I","love","Lucinda").drop_while{|e| e.length <=5})
      assert_equal(["love","Lucinda"],Triple.new("I","love","Lucinda").drop_while{|e| e.length == 1})
    #  assert_equal(true,Triple.new("I","love","Lucinda").drop_while.is_a?(Enumerator))
    end

    def test_each_cons
      #https://stackoverflow.com/questions/14987362/how-can-i-capture-stdout-to-a-string
      std = StringIO.new
      $stdout = std

      Triple.new("I","love","Lucinda").each_cons(2) {|e| p e}
      assert_equal("[\"I\", \"love\"]\n[\"love\", \"Lucinda\"]\n", $stdout.string)
  #    assert_equal(true,Triple.new("I","love","Lucinda").each_cons(2).is_a?(Enumerator))
    end

    def test_each_entry
    #  assert_equal(true,Triple.new("I","love","Lucinda").each_entry{|e| p e}.is_a?(Enumerable))
    end

    def test_each_slice
      #https://stackoverflow.com/questions/14987362/how-can-i-capture-stdout-to-a-string
      std = StringIO.new
      $stdout = std

      Triple.new("I","love","Lucinda").each_slice(2) {|e| p e}
      assert_equal("[\"I\", \"love\"]\n[\"Lucinda\"]\n", $stdout.string)
  #    assert_equal(true,Triple.new("I","love","Lucinda").each_slice(2).is_a?(Enumerator))
    end

    def test_each_with_index
      #https://stackoverflow.com/questions/14987362/how-can-i-capture-stdout-to-a-string
      std = StringIO.new
      $stdout = std

      Triple.new("I","love","Lucinda").each_with_index {|e,i| p e << "#{i}"}
      assert_equal("\"I0\"\n\"love1\"\n\"Lucinda2\"\n", $stdout.string)
  #    assert_equal(true,Triple.new("I","love","Lucinda").each_with_index.is_a?(Enumerator))
    end

    def test_each_with_object
      assert_equal("I---love---Lucinda---",Triple.new("I","love","Lucinda").each_with_object(""){|e,obj| obj << "#{e}---"})
  #    assert_equal(true,Triple.new("I","love","Lucinda").each_with_object("").is_a?(Enumerator) )
    end

    def test_entries
      assert_equal(["I","love","Lucinda"], Triple.new("I","love","Lucinda").entries)
    end

    def test_find
      assert_equal("love",Triple.new("I","love","Lucinda").find(ifnone=nil){|e| e.length == 4})
      assert_equal("I",Triple.new("I","love","Lucinda").find(ifnone=nil){|e| e.length == 1})
      assert_equal(nil,Triple.new("I","love","Lucinda").find(ifnone=nil){|e| e.length == 3})
      assert_equal(nil,Triple.new("I","love","Lucinda").find{|e| e.length == 3})
    #  assert_equal(true,Triple.new("I","love","Lucinda").find.is_a?(Enumerator))
    end

    def test_find_all
      assert_equal(["I","Lucinda"],Triple.new("I","love","Lucinda").find_all{|e| e.length != 4})
    #  assert_equal(true,Triple.new("I","love","Lucinda").find_all.is_a?(Enumerator))
    end

    def test_select
      assert_equal(["I","Lucinda"],Triple.new("I","love","Lucinda").select{|e| e.length != 4})
    #  assert_equal(true,Triple.new("I","love","Lucinda").select.is_a?(Enumerator))
    end

    def test_find_index
      assert_equal(1,Triple.new("I","love","Lucinda").find_index("love"))
      assert_equal(0,Triple.new("I","love","Lucinda").find_index("I"))
      assert_equal(nil,Triple.new("I","love","Lucinda").find_index("yo"))
      assert_equal(1,Triple.new("I","love","Lucinda").find_index{|e| e.length == 4})
    #  assert_equal(true,Triple.new("I","love","Lucinda").find_index.is_a?(Enumerator))
    end

    def test_first
      assert_equal("I",Triple.new("I","love","Lucinda").first)
      assert_equal(["I","love"],Triple.new("I","love","Lucinda").first(2))
      assert_equal(nil,[].first)
      assert_equal([],[].first(3))
    end

    def test_grep
      assert_equal(["love"],Triple.new("I","love","Lucinda").grep(/lo(.*)/))
      assert_equal(["love you"],Triple.new("I","love","Lucinda").grep(/lo(.*)/){|e| e << " you"})
    end

    def test_grep_v
      assert_equal(["I","Lucinda"],Triple.new("I","love","Lucinda").grep_v(/lo(.*)/))
      assert_equal(["I you","Lucinda you"],Triple.new("I","love","Lucinda").grep_v(/lo(.*)/){|e| e << " you"})
    end

    def test_group_by
      assert_equal({true=>["I","Lucinda"],false=>["love"]},Triple.new("I","love","Lucinda").group_by{|e| e.length !=4})
    #  assert_equal(true,Triple.new("I","love","Lucinda").group_by.is_a?(Enumerator))
    end

    def test_include
      assert_equal(true,Triple.new("I","love","Lucinda").include?("I"))
      assert_equal(true,Triple.new("I","love","Lucinda").include?("love"))
      assert_equal(true,Triple.new("I","love","Lucinda").include?("Lucinda"))
      assert_equal(false,Triple.new("I","love","Lucinda").include?("lucinda"))
    end

    def test_inject
      assert_equal("!!IloveLucinda",Triple.new("I","love","Lucinda").inject("!!",:<<))
      assert_equal("IloveLucinda",Triple.new("I","love","Lucinda").inject(:<<))
      assert_equal("!!IloveLucinda",Triple.new("I","love","Lucinda").inject("!!"){|result,e| result << e})
      assert_equal("IloveLucinda",Triple.new("I","love","Lucinda").inject{|result,e| result << e})
    end

    def test_reduce
      assert_equal("!!IloveLucinda",Triple.new("I","love","Lucinda").reduce("!!",:<<))
      assert_equal("IloveLucinda",Triple.new("I","love","Lucinda").reduce(:<<))
      assert_equal("!!IloveLucinda",Triple.new("I","love","Lucinda").reduce("!!"){|result,e| result << e})
      assert_equal("IloveLucinda",Triple.new("I","love","Lucinda").reduce{|result,e| result << e})
    end

    def test_max
      assert_equal("love",Triple.new("I","love","Lucinda").max)
      assert_equal("Lucinda",Triple.new("I","love","Lucinda").max{|a,b| a.length <=> b.length})
      assert_equal(["love","Lucinda"],Triple.new("I","love","Lucinda").max(2))
      assert_equal(["Lucinda","love"],Triple.new("I","love","Lucinda").max(2){|a,b| a.length <=> b.length})
    end

    def test_max_by
      assert_equal("Lucinda",Triple.new("I","love","Lucinda").max_by{|e| e.length})
    #  assert_equal(true,Triple.new("I","love","Lucinda").max_by.is_a?(Enumerator))
      assert_equal(["Lucinda","love"],Triple.new("I","love","Lucinda").max_by(2){|e| e.length})
    #  assert_equal(true,Triple.new("I","love","Lucinda").max_by(2).is_a?(Enumerator))
    end

    def test_member
      assert_equal(true,Triple.new("I","love","Lucinda").member?("love"))
      assert_equal(false,Triple.new("I","love","Lucinda").member?("Love"))
    end

    def test_min
      assert_equal("I",Triple.new("I","love","Lucinda").min)
      assert_equal("I",Triple.new("I","love","Lucinda").min{|a,b| a.length <=> b.length})
      assert_equal(["I","Lucinda"],Triple.new("I","love","Lucinda").min(2))
      assert_equal(["I","love"],Triple.new("I","love","Lucinda").min(2){|a,b| a.length <=> b.length})
    end

    def test_min_by
      assert_equal("I",Triple.new("I","love","Lucinda").min_by{|e| e.length})
  #    assert_equal(true,Triple.new("I","love","Lucinda").min_by.is_a?(Enumerator))
      assert_equal(["I","love"],Triple.new("I","love","Lucinda").min_by(2){|e| e.length})
  #    assert_equal(true,Triple.new("I","love","Lucinda").min_by(2).is_a?(Enumerator))
    end

    def test_minmax
      assert_equal(["I","love"],Triple.new("I","love","Lucinda").minmax)
      assert_equal(["I","Lucinda"],Triple.new("I","love","Lucinda").minmax{|a,b| a.length <=> b.length})
    end

    def test_minmax_by
      assert_equal(["I","Lucinda"],Triple.new("I","love","Lucinda").minmax_by{|e| e.length})
  #    assert_equal(true,Triple.new("I","love","Lucinda").minmax_by.is_a?(Enumerator))
    end

    def test_none
      assert_equal(true,Triple.new("I","love","Lucinda").none?{|e| e.length == 5})
      assert_equal(false,Triple.new("I","love","Lucinda").none?{|e| e.length == 4})
      assert_equal(true,[].none?)
      assert_equal(false,Triple.new("I","love","Lucinda").none?)
    end

    def test_one
      assert_equal(false,Triple.new("I","love","Lucinda").one?{|e| e.length == 5})
      assert_equal(true,Triple.new("I","love","Lucinda").one?{|e| e.length == 4})
      assert_equal(true,[false,true].one?)
      assert_equal(false,Triple.new("I","love","Lucinda").one?)
    end

    def test_partition
      assert_equal([["I","Lucinda"],["love"]],Triple.new("I","love","Lucinda").partition{|e| e.length != 4})
  #    assert_equal(true,Triple.new("I","love","Lucinda").partition.is_a?(Enumerator))
    end

    def test_reject
      assert_equal(["I","Lucinda"],Triple.new("I","love","Lucinda").reject{|e| e.length == 4})
  #    assert_equal(true,Triple.new("I","love","Lucinda").reject.is_a?(Enumerator))
    end

    def test_reverse_each
      #https://stackoverflow.com/questions/14987362/how-can-i-capture-stdout-to-a-string
      std = StringIO.new
      $stdout = std

      Triple.new("I","love","Lucinda").reverse_each{|e| p e}
      assert_equal("\"Lucinda\"\n\"love\"\n\"I\"\n", $stdout.string)
    #  assert_equal(true,Triple.new("I","love","Lucinda").reverse_each.is_a?(Enumerator))
    end

    def test_slice_after
      assert_equal([["I","love"],["Lucinda"]], Triple.new("I","love","Lucinda").slice_after(/e/).to_a)
      assert_equal([["I","love"],["Lucinda"]], Triple.new("I","love","Lucinda").slice_after{|e| e.length == 4}.to_a)
    end

    def test_slice_before
      assert_equal([["I","love"],["Lucinda"]], Triple.new("I","love","Lucinda").slice_before(/L/).to_a)
      assert_equal([["I","love"],["Lucinda"]], Triple.new("I","love","Lucinda").slice_before{|e| e.length == 7}.to_a)
    end

    def test_slice_when
      assert_equal([["I","love"],["Lucinda"]],Triple.new("I","love","Lucinda").slice_when{|a,b| a.length + b.length > 7}.to_a)
    end

    def test_sort #increasing order
      assert_equal(["I","Lucinda","love"],Triple.new("I","love","Lucinda").sort)
      assert_equal(["I","love","Lucinda"],Triple.new("I","love","Lucinda").sort{|a,b| a.length <=> b.length})
    end

    def test_sort_by
      assert_equal(["I","love","Lucinda"],Triple.new("I","love","Lucinda").sort_by{|e| e.length})
  #    assert_equal(true,Triple.new("I","love","Lucinda").sort_by.is_a?(Enumerator))
    end

    def test_sum
      assert_equal(12,Triple.new("I","love","Lucinda").sum(init=0){|e| e.length})
    end

    def test_take
      assert_equal(["I","love"],Triple.new("I","love","Lucinda").take(2))
      assert_equal(["I"],Triple.new("I","love","Lucinda").take(1))
    end

    def test_take_while
      assert_equal(["I","love"],Triple.new("I","love","Lucinda").take_while{|e| e.length < 5})
  #    assert_equal(true,Triple.new("I","love","Lucinda").take_while.is_a?(Enumerator))
    end

    def test_to_a
      assert_equal(["I","love","Lucinda"],Triple.new("I","love","Lucinda").to_a)
    end

    def test_to_h #increasing order of key
      #followed the test on Ruby: https://ruby-doc.org/core-2.4.1/Enumerable.html#method-i-find
      #assert_equal({"I"=>0,"Lucinda"=>2,"love"=>1,},Triple.new("I","love","Lucinda").each_with_index.to_h)
      assert_equal({"I"=>1,"love"=>2,"Lucinda"=>3,},Triple.new(["I",1],["love",2],["Lucinda",3]).to_h)
    end

    def test_uniq
      assert_equal(["I","love","Lucinda"], Triple.new("I","love","Lucinda").uniq)
      assert_equal(["I","love","Lucinda"], Triple.new("I","love","Lucinda").uniq{|e| e.length})
    end

    def test_zip
      arr = [1,2]
      assert_equal([["I",1],["love",2],["Lucinda",nil]],Triple.new("I","love","Lucinda").zip(arr))
      arr = [1,2,3]
      assert_equal([["I",1],["love",2],["Lucinda",3]],Triple.new("I","love","Lucinda").zip(arr))
      result = []
      Triple.new("I","love","Lucinda").zip(arr){|a,b| result << a.length + b}
      assert_equal([2,6,10],result)
    end

end
