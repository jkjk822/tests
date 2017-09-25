require 'rspec/autorun'
require 'rantly/rspec_extensions'

describe Triple do

  before do
    @triple = Triple.new(nil,nil,nil)
  end

  # it 'should contain three nils' do
  #   expect(@triple._1).to eq nil
  #   expect(@triple._2).to eq nil
  #   expect(@triple._3).to eq nil
  # end

  describe '#all?' do
    it 'return false if there is a false/nil' do
      @triple = Triple.new(false, 1, 'a')
      expect(@triple.all?).to be false

      @triple = Triple.new(true, 2, nil)
      expect(@triple.all?).to be false
    end

    it 'return true if all element is not false/nil' do
      property_of {
        array(3) { i = integer; guard i > 0; i }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.all?).to be true
        expect(@triple.all? {|i| i < 0}).to be false
      }
    end
  end

  describe '#any?' do
    it 'return true if there is something not false/nil' do
      @triple = Triple.new(false, 1, 'a')
      expect(@triple.any?).to be true
    end

    it 'return false if everything is false/nil' do
      @triple = Triple.new(false, false, nil)
      expect(@triple.any?).to be false
    end

    it 'return true if all element is not false/nil' do
      property_of {
        array(3) { i = integer; guard i > 0; i }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.any?).to be true
        expect(@triple.any? {|i| i < 0}).to be false
      }
    end
  end

  # describe '#chunk' do
  #   it 'group elements based on block' do
  #     @triple = Triple.new(1, 'a', 2)
  #     a = @triple.chunk{|x| x.class == String}
  #     expect(a[0][0]).to be false
  #     expect(a[1][0]).to be true
  #     expect(a[2][0]).to be false
  #   end
  # end

  describe '#chunk_while' do
    it 'group elements based on two-arguments block' do
      property_of {
        i = integer.abs
        [i/4, i/2, i]
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        iter = @triple.chunk_while { |i,j| i < j }
        expect(iter.to_a).to eq [[t1, t2, t3]]
      }
    end
  end

  describe '#collect' do
    it 'return a new array with results of running block' do
      property_of {
        array(3) { integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        lam = ->(a) { a + 1 }
        expect([t1, t2, t3].collect &lam).to eq ([t1, t2, t3].map &lam)
      }
    end
  end

  describe '#collect_concat' do
    it 'behave like flatMap' do
      property_of {
        array(3) { array {integer} }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.collect_concat {|e| ['black']}).to eq\
          ['black', 'black', 'black']
      }
    end
  end

  describe '#count' do
    it 'return counts equal to argument' do
      @triple = Triple.new(9,42,9)
      expect(@triple.count(9)).to eq 2
    end

    it 'counts the number of element' do
      property_of {
        array(3) { positive_integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.count).to eq 3
        expect(@triple.count {|x| x > 0}).to eq 3
      }
    end
  end

  # describe '#cycle' do
  #   it 'repeat elements n times' do
  #     property_of {
  #       array(3) { integer }
  #     }.check { |t1, t2, t3|
  #       @triple = Triple.new(t1,t2,t3)
  #       a = @triple.cycle(1).to_a
  #       expect(a).to eq [t1,t2,t3]
  #     }
  #   end
  # end

  describe '#detect' do
    it 'find the first element that not result false' do
      property_of {
        [integer, string, float]
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.detect {|x| x.class == String}).to eq t2
      }
    end
  end

  describe '#drop' do
    it 'drops n elements' do
      property_of {
        array(3) { integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.drop 1).to eq [t2,t3]
        expect(@triple.drop 42).to eq []
      }
    end
  end

  describe '#drop_while' do
    it 'keep droping while true' do
      property_of {
        array(3) { positive_integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.drop_while {|x| x < 0}).to eq [t1, t2, t3]
        expect(@triple.drop_while {|x| true}).to eq []
      }
    end
  end

  describe '#each_cons' do
    it 'iterate given block for each consecutive n elem' do
      @triple = Triple.new(25, 9, 66); res = []
      @triple.each_cons(2) {|x| res << x}
      # expect(iter[0]).to eq [25,9]
      # expect(iter[1]).to eq [9,66]
      expect(res).to eq [[25,9],[9,66]]
    end
  end

  # describe '#each_entry' do
  #   it 'seems not very useful' do
  #     @triple.value = [1,2,3]
  #     expect(@triple.each_entry {|x| x}).to eq @triple
  #   end
  # end

  describe '#each_slice' do
    it 'run block on sliced result' do
      @triple = Triple.new(114514, 1919, 19)
      res = []; iter = @triple.each_slice(2) {|x| res << x}
      expect(res).to eq [[114514, 1919], [19]]
    end
  end

  # describe '#each_with_index' do
  #   it 'iterate with index' do
  #     property_of {
  #       array(3) { integer }
  #     }.check { |t1,t2,t3|
  #       @triple = Triple.new(t1,t2,t3)
  #       @triple.each_with_index do |x, idx|
  #         code = "expect(@triple._#{idx+1}).to eq #{x}"
  #         eval(code)
  #       end
  #     }
  #   end
  # end

  describe '#each_with_object' do
    it 'is a kind of foldl' do
      property_of {
        array(3) { integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.each_with_object([]) {|b, a| a << b}).to eq [t1, t2, t3]
      }
    end
  end

  describe '#entries' do
    it 'looks like toList' do
      property_of {
        array(3) { integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.entries).to eq [t1, t2, t3]
      }
    end
  end

  describe '#find' do
    it 'find the first element that not result false' do
      property_of {
        [integer, string, float]
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.find {|x| x.class == String}).to eq t2
      }
    end
  end

  describe '#find_all' do
    it 'finds all elements that not result false' do
      property_of {
         array(3) { positive_integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.find_all {|x| x > 0}).to eq [t1, t2, t3]
        expect(@triple.find_all {|x| x < 0}).to eq []
      }
    end
  end

  describe '#find_index' do
    it 'finds the index of first legal element' do
      @triple = Triple.new(-1,-2,-3)
      expect(@triple.find_index {|x| x == -1}).to be 0
      expect(@triple.find_index {|x| x == 114}).to be nil
    end
  end

  describe '#first' do
    it 'takes the first element' do
      @triple = Triple.new(1,2,3)
      expect(@triple.first).to eq 1
      expect(@triple.first(2)).to eq [1,2]
    end

    it 'is very strange when empty' do
      @triple = Triple.new(nil, nil, nil)

      # from the document
      expect(@triple.first).to eq nil
      expect(@triple.first(5)).to eq [nil,nil,nil]
    end
  end

  describe '#flat_map' do
    it 'is the same as each_concat' do
      property_of {
        array(3) { integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.flat_map {|x| [x]}).to eq [t1, t2, t3]
      }
    end
  end

  describe '#grep' do
    it 'use regex to match elements' do
      @triple = Triple.new('ruihan', 'wang', 'cirno')
      expect(@triple.grep(/a/)).to eq %w(ruihan wang)
      expect(@triple.grep(/cirno/) {|x| x + ' seikou'}).to eq\
        ['cirno seikou']
    end
  end

  describe '#grep_v' do
    it 'likes #grep but return its complement' do
      @triple = Triple.new('ruihan', 'wang', 'cirno')
      expect(@triple.grep_v(/a/)).to eq ['cirno']
      expect(@triple.grep_v(/cirno/) {|x| x + ' seikou'}).to eq\
        ['ruihan seikou', 'wang seikou']
    end
  end

  describe '#group_by' do
    it 'sort elements into a hash' do
      @triple = Triple.new('cirno', 9, 'ice')
      expect(@triple.group_by {|x| x.class == String}).to eq\
        Hash[true => %w(cirno ice), false => [9]]
    end
  end

  describe '#include?' do
    it 'return true if include element' do
      property_of {
        array(3) { integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.include?(t1)).to be true
        expect(@triple.include?('foo')).to be false
      }
    end
  end

  describe '#inject' do
    it 'is foldr' do
      property_of {
        array(3) { integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.inject(&:+)).to eq t1+t2+t3
        expect(@triple.inject(-1, &:+)).to eq -1+t1+t2+t3
      }
    end
  end

  # describe '#lazy' do
  #   it 'will delay evaluation until force' do
  #     @triple.value = [1,2,3]
  #     expect(@triple.lazy.class).to eq Enumerator::Lazy
  #   end
  # end

  describe '#map' do
    it 'return a new array and apply funcion' do
      property_of {
        array(3) { integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.map {|_| 42}).to eq [42,42,42]
      }
    end
  end

  describe '#max' do
    it 'return the maximum value' do
      property_of {
        array(3) { integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.max).to eq [t1, t2, t3].sort.at(2)
      }
    end
  end

  describe '#max_by' do
    it 'use block to choose max value' do
      property_of {
        [sized(5) {string}, sized(30) {string}, sized(9) {string}]
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.max_by {|s| s.length}).to eq t2
      }
    end
  end

  describe '#member?' do
    it 'is an alias of #include?' do
      property_of {
        array(3) { integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.member?(t1)).to eq @triple.include?(t1)
        expect(@triple.member?('something else')).to be false
      }
    end
  end

  describe '#min' do
    it 'should return the minimum element' do
      property_of {
        array(3) { integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.min).to eq @triple.sort.at(0)
      }
    end
  end

  describe '#min_by' do
    it 'use block to choose min value' do
      property_of {
        [sized(5) {string}, sized(30) {string}, sized(9) {string}]
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.min_by {|s| s.length}).to eq t1
        expect(@triple.min_by(2) {|s| s.length}).to eq [t1,t3]
      }
    end
  end

  describe '#minmax' do
    it 'return [min, max] value' do
      property_of {
        i = integer
        [i, i+1, i+2]
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.minmax).to eq [t1,t3]
        expect(@triple.minmax(&:<=>)).to eq @triple.minmax
      }
    end
  end

  describe '#minmax_by' do
    it 'return [min, max] value use result from block' do
      property_of {
        array(3) { integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.minmax_by {|a| a}).to eq @triple.minmax
      }
    end
  end

  describe '#none?' do
    it 'return true if there is nothing/nil' do
      @triple = Triple.new(nil, nil, nil)
      expect(@triple.none?).to be true
    end

    it 'inidicate result use a block' do
      property_of {
        array(3) { integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.none? {|x| x > 0}).to eq \
          @triple.all? {|x| x <= 0}
      }
    end
  end

  describe '#one?' do
    it 'return false if there is nothing/nil' do
      @triple = Triple.new(nil, nil, nil)
      expect(@triple.one?).to be false
    end

    it 'inidicate result occur exactly once' do
      property_of {
        [ -positive_integer, positive_integer, positive_integer]
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.one? {|x| x > 0}).to eq \
          (not @triple.one? {|x| x <= 0})
      }
    end
  end

  describe '#partition' do
    it 'return [true_ele, false_ele] based on block' do
      property_of {
        array(3) { integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        lam = ->(a) { a > 0 }
        expect(@triple.partition(&lam).first.all?(&lam)).to be true
      }
    end
  end

  describe '#reduce' do
    it 'should fold the element' do
      property_of {
        array(3) { string }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.reduce('foo', &:+)).to eq ('foo'+t1+t2+t3)
      }
    end
  end

  describe '#reject' do
    it 'should return elements that result false' do
      property_of {
        array(3) { string }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        lam = ->(s) { s.length > 9 }
        expect(@triple.reject &lam).to eq @triple.select &->(s) { not lam[s] }
      }
    end
  end

  describe '#reverse_each' do
    it 'traverse the structure in reverse order' do
      property_of {
        array(3) { string }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)

        # sadly, side effects
        var = [] ; @triple.reverse_each {|e| var << e}
        @triple = Triple.new(var[0], var[1], var[2]); var = []
        @triple.reverse_each {|e| var << e}
        expect(var).to eq [t1,t2,t3]
      }
    end
  end

  describe '#select' do
    it 'is alias of choose' do
      property_of {
        array(3) { string }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.select {|_| true}).to eq [t1, t2, t3]
        expect(@triple.select {|_| false}).to eq []
      }
    end
  end

  describe '#slice_after' do
    it 'chunk element until pattern runs true' do
      @triple = Triple.new('cirno', 'break', 'sdvx')
      expect(@triple.slice_after(/break?/).to_a).to eq [%w(cirno break), ['sdvx']]
    end
  end

  describe '#slice_before' do
    it 'chunk element until pattern runs true' do
      @triple = Triple.new('cirno', 'break', 'sdvx')
      expect(@triple.slice_before(/break?/).to_a).to eq [['cirno'], ['break','sdvx']]
    end
  end

  describe '#slice_when' do
    it 'slice a chunk when block runs true' do
      @triple = Triple.new(2,4,6)
      expect(@triple.slice_when(&->(i,j) {i ** 2 == j}).to_a).to eq [[2],[4,6]]
    end
  end

  describe '#sort' do
    it 'sort through the structure' do
      property_of {
        array(3) { integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.sort.minmax).to eq  [@triple.sort.at(0), @triple.sort.at(2)]
      }
    end
  end

  describe '#sort_by' do
    it 'sort based on block result' do
      @triple = Triple.new('touhou', 'gensokyo', 'reimu')
      expect(@triple.sort_by {|s| s.length}).to eq %w(reimu touhou gensokyo)
    end
  end

  describe '#sum' do
    it 'sum all the element' do
      property_of {
        array(3) { string }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.sum('')).to eq @triple.reduce('', &:+)
        expect(@triple.sum('') {|s| s + '1s'}).to eq t1+'1s' + t2+'1s' + t3+'1s'
      }
    end
  end

  describe '#take' do
    it 'takes the first n elements' do
      property_of {
        array(3) { integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.take(0)).to eq []
        expect(@triple.take(200)).to eq [t1, t2, t3]
      }
    end
  end

  describe '#take' do
    it 'takes elements while true' do
      property_of {
        array(3) { integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.take_while {|_| true}).to eq [t1, t2, t3]
        expect(@triple.take_while {|_| false}).to eq []
      }
    end
  end

  describe '#to_a' do
    it 'collapse the structure to an array' do
      property_of {
        array(3) { integer }
      }.check { |t1,t2,t3|
        @triple = Triple.new(t1,t2,t3)
        expect(@triple.to_a).to eq [t1, t2, t3]
      }
    end
  end

  describe '#to_h' do
    it 'collapse the structure to an hash' do
      @triple = Triple.new(%w(cirno strongest), %w(helpme erin!!!),%w(foo bar))
      expect(@triple.to_h['helpme']).to eq 'erin!!!'
    end
  end

  describe '#uniq' do
    it 'remove the redundant elements' do
      @triple = Triple.new('foo', 'foo', 'bar')
      expect(@triple.uniq).to eq %w(foo bar)
      expect(@triple.uniq {|x| x.length}).to eq ['foo']
    end
  end

  # describe '#zip' do
  #   it 'zip two structure to an array of array' do
  #     triple2 = Triple.new(1,2,3)
  #     @triple = Triple.new(4,5,6)
  #     expect(@triple.zip(triple2.value)).to eq [[4,1],[5,2],[6,3]]
  #     arr = []
  #     @triple.zip(triple2.value) {|x,y| arr << x-y}
  #     triple3 = Triple.new(arr[0], arr[1], arr[2])
  #     expect(triple3.value).to eq [3,3,3]
  #   end
  # end
end