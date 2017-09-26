require 'rspec/autorun'

describe Triple do

    before(:each) do
        @nums = Triple.new(1,2,3)
        @truenil = Triple.new(true,true,nil)
        @allfalsey = Triple.new(false,nil,false)
        @jumbled = Triple.new(2,1,3)
    end


    describe "#all?" do
        context "when a block is provided" do
            it "returns true if all cause the block to be true" do
                ret = @nums.all? {|e| e > 0}
                expect(ret).to be true
            end

            it "returns false if at least one causes the block to not be true" do
                ret = @nums.all? {|e| e > 1}
                expect(ret).to be false
            end
        end
        context "when no block is provided" do
            it "returns true if all elements are truthy" do
                ret = @nums.all?
                expect(ret).to be true
            end

            it "returns false if not all elements are truthy" do
                ret = @truenil.all?
                expect(ret).to be false
            end
        end
    end

    describe "#any?" do
        context "when a block is provided" do
            it "returns true if any cause the block to be true" do
                ret = @nums.any? {|e| e > 1}
                expect(ret).to be true
            end

            it "returns false if none cause the block to be true" do
                ret = @nums.any? {|e| e > 3}
                expect(ret).to be false
            end
        end
        context "when no block is provided" do
            it "returns true if any elements are truthy" do
                ret = @nums.any?
                expect(ret).to be true
            end

            it "returns false if all elements are not truthy" do
                ret = @allfalsey.any?
                expect(ret).to be false
            end
        end

    end

    describe "#chunk" do
        it "chunks consecutive items that give the same return value from the block" do
            ret = @nums.chunk {|e| e > 1}
            expect(ret).to match_array([[false, [1]], [true, [2,3]]])
        end

        it "drops elements for which the block returns nil" do
            ret = @nums.chunk {|e| e != 2 || nil}
            expect(ret).to match_array([[true, [1]], [true, [3]]])
        end

        it "isolates elements for which the block returns :_alone" do
            ret = @nums.chunk {|e| :_alone}
            expect(ret).to match_array([[:_alone, [1]],[:_alone, [2]],[:_alone, [3]]])
        end
    end

    describe "#chunk_while" do
        it "chunks based on the two-argument block" do
            ret = @allfalsey.chunk_while {|b,a| a == false}
            expect(ret).to match_array([[false], [nil,false]])
        end
    end

    describe "#collect and #map" do
        it "map the given operation" do
            ret1 = @nums.collect { |n| n * -1 }
            ret2 = @nums.map { |n| n * -1 }
            expect(ret1).to eq([-1,-2,-3])
            expect(ret1).to eq(ret2)
        end
    end

    describe "#collect_concat and #flat_map" do
        it "return a flattened map output" do
            ret1 = @nums.collect_concat {|e| [e, e+1]}
            ret2 = @nums.flat_map {|e| [e, e+1]}
            expect(ret1).to eq([1,2,2,3,3,4])
            expect(ret1).to eq(ret2)
        end
    end

    describe "#count" do
        context "when no block nor argument is provided" do
            it "returns the number of elements in the collection" do
                ret = @nums.count
                expect(ret).to eq(3)
            end
        end
        context "when an argument is provided" do
            it "returns the number of items equal to the argument" do
                ret = @nums.count(2)
                expect(ret).to eq(1)
            end
        end
        context "when a block is provided" do
            it "returns the number of items for which the block is true" do
                ret = @nums.count {|e| e > 1}
                expect(ret).to eq(2)
            end
        end
    end

    describe "#cycle" do
        context "when a non-nil argument is provided" do
            context "with a block" do
                it "cycles through the collection n times and calls the block" do
                    ret = []
                    @nums.cycle(2) {|e| ret << e}
                    expect(ret).to match_array([1,2,3,1,2,3])
                end
            end
        end
    end

    describe "#detect and #find" do
        context "when a block is provided" do
            context "without an argument" do
                it "return the first item that causes the block to be truthy" do
                    ret1 = @nums.detect {|e| e > 1}
                    ret2 = @nums.find {|e| e > 1}
                    expect(ret1).to eq(2)
                    expect(ret1).to eq(ret2)
                end
            end
            context "with an argument" do
                it "call the argument and return the result if no match is found in the collection" do
                    ifnone = lambda {42}
                    ret1 = @nums.detect(ifnone) {|e| e > 3}
                    ret2 = @nums.find(ifnone) {|e| e > 3}
                    expect(ret1).to eq(42)
                    expect(ret1).to eq(ret2)
                end
            end
        end
    end

    describe "#drop" do
        it "drops the first n elements and returns the rest as an array" do
            ret = @nums.drop(1)
            expect(ret).to eq([2,3])
        end
        it "doesn't drop anything if 0 is passed" do
            ret = @nums.drop(0)
            expect(ret).to eq([1,2,3])
        end
    end

    describe "#drop_while" do
        context "when a block is provided" do
            it "drops until the block is not truthy" do
                ret = @nums.drop_while {|e| e != 2}
                expect(ret).to match_array([2,3])
            end
        end
    end

    describe "#each_cons" do
        it "calls the block on each consecutive subarray of n items" do
            ret = []
            @nums.each_cons(2) {|a| ret << a}
            expect(ret).to match_array([[1,2],[2,3]])
        end
    end

    describe "#each_entry" do
        context "when a block is provided" do
            it "calls the block for each element in the collection, collecting multi-yields into an array" do
                ret = []
                @nums.each_entry {|a| ret << a}
                expect(ret).to match_array([1,2,3])
            end
        end
    end

    describe "#each_slice" do
        it "iterates the block for each slice of (up to) n elements" do
            ret = []
            @nums.each_slice(2) {|a| ret << a}
            expect(ret).to match_array([[1,2],[3]])
        end
    end

    describe "#each_with_index" do
        it "calls the block with each element and its index" do
            ret = []
            @nums.each_with_index {|e,i| ret << e+i}
            expect(ret).to match_array([1,3,5])
        end
    end

    describe "#each_with_object" do
        it "iterates the block and passes the given argument as well, returning it after" do
            ret = @nums.each_with_object([]) {|e,a| a << e}
            expect(ret).to match_array([1,2,3])
        end
    end

    describe "#entries" do
        it "returns an array with the items in the collection" do
            ret = @nums.entries
            expect(ret).to match_array(@nums)
        end
    end

    describe "#find_all" do
        it "returns an array of all elements for which the block is true" do
            ret = @nums.find_all {|e| e > 2}
            expect(ret).to eq([3])
        end
    end

    describe "#find_index" do
        context "when an argument is provided" do
            it "returns the index of the first element matching the argument" do
                ret = @nums.find_index(2)
                expect(ret).to eq(1)
            end
            it "returns nil if the item is not present" do
                ret = @nums.find_index(4)
                expect(ret).to be_nil
            end
        end
        context "when a block is provided" do
            it "returns the index of the first element for which the block is true" do
                ret = @nums.find_index {|e| e > 1}
                expect(ret).to eq(1)
            end
        end
    end

    describe "#first" do
        context "when no argument is provided" do
            it "returns the first element if present" do
                ret = @nums.first 
                expect(ret).to eq(1)
            end
        end
        context "when an argument is provided" do
            it "returns the first n elements" do
                ret = @nums.first(2)
                expect(ret).to match_array([1,2])
            end
        end
    end

    describe "#grep" do
        context "when no block is provided" do
            it "returns an array of every element for which the argument === the element" do
                ret = @allfalsey.grep(FalseClass)
                expect(ret).to match_array([false,false])
            end
            it "returns an empty list if no matches" do
                ret = @nums.grep(FalseClass)
                expect(ret).to be_empty
            end
        end
        context "when a block is provided" do
            it "passes all matches to the block and collects the results" do
                ret = @allfalsey.grep(FalseClass) {|e| !e}
                expect(ret).to match_array([true,true])
            end
        end
    end

    describe "#grep_v" do
        context "when no block is provided" do
            it "returns an array of every element for which the argument doesn't === the element" do
                ret = @allfalsey.grep_v(FalseClass)
                expect(ret).to match_array([nil])
            end
            it "returns an empty list if all match" do
                ret = @nums.grep_v(Integer)
                expect(ret).to be_empty
            end
        end
        context "when a block is provided" do
            it "passes all non-matches to the block and collects the results" do
                ret = @allfalsey.grep_v(FalseClass) {|e| e}
                expect(ret).to match_array([nil])
            end
        end

    end

    describe "#group_by" do
        it "returns a hash where keys are the block results and values are the elements giving those results" do
            ret = @nums.group_by {|e| e%2 == 0}
            expect(ret).to include(true => [2], false => [1,3])
        end
    end

    describe "#include?" do
        it "returns true if any element equals the argument" do
            ret = @nums.include?(2)
            expect(ret).to be true
        end
        it "returns false if no elements equal the argument" do
            ret = @nums.include?(4)
            expect(ret).to be false
        end
    end

    describe "#inject and #reduce" do
        context "when no block is provided" do
            context "and two arguments are provided" do
                it "reduce using the initial argument and the given operation" do
                    ret1 = @nums.reduce(-1,:+)
                    ret2 = @nums.inject(-1,:+)
                    expect(ret1).to eq(5)
                    expect(ret1).to eq(ret2)
                end
            end
            context "and one argument is provided" do
                it "reduce using the specified symbol (assumes first element is initial value)" do
                    ret1 = @nums.reduce(:*)
                    ret2 = @nums.inject(:*)
                    expect(ret1).to eq(6)
                    expect(ret1).to eq(ret2)
                end
            end
        end
        context "when a block is provided" do
            context "and an argument is provided" do
                it "reduce using the initial value and the block" do
                    ret1 = @nums.reduce(-1) {|m,e| m+e}
                    ret2 = @nums.inject(-1) {|m,e| m+e}
                    expect(ret1).to eq(5)
                    expect(ret1).to eq(ret2)
                end
            end
            context "and no argument is provided" do
                it "reduces using the block" do
                    ret1 = @nums.reduce {|m,e| m*e}
                    ret2 = @nums.inject {|m,e| m*e}
                    expect(ret1).to eq(6)
                    expect(ret1).to eq(ret2)
                end
            end
        end
    end

    describe "#max" do
        context "when no block is provided" do
            context "and an argument is provided" do
                it "returns the max (assumes Comparable) n elements" do
                    ret = @nums.max(2)
                    expect(ret).to eq([3,2])
                end
            end
            context "and no argument is provided" do
                it "returns the max element (assumes Comparable)" do
                    ret = @nums.max
                    expect(ret).to eq(3)
                end
            end
        end
        context "when a block is provided" do
            context "and an argument is provided" do
                it "uses the block to return the max n elements" do
                    ret = @nums.max(2) {|a,b| -a <=> -b}
                    expect(ret).to eq([1,2])
                end
            end
            context "and no argument is provided" do
                it "uses the block to return the max element" do
                    ret = @nums.max {|a,b| -a <=> -b}
                    expect(ret).to eq(1)
                end
            end
        end
    end

    describe "#max_by" do
        context "when no argument is provided" do
            it "returns the element that gives the max block value" do
                ret = @nums.max_by {|e| e + 2*((e+1)%2)}
                expect(ret).to eq(2)
            end 
        end 
        context "when an argument is provided" do
            it "returns the elements yielding the max n block values" do
                ret = @nums.max_by(2) {|e| -e}
                expect(ret).to eq([1,2])
            end
        end
    end

    describe "#member?" do
        it "returns true if any element equals the argument" do
            ret = @nums.member?(2)
            expect(ret).to be true
        end
        it "returns false if no element equals the argument" do
            ret = @nums.member?(4)
            expect(ret).to be false
        end
    end

    describe "#min" do
        context "when no block is provided" do
            context "and an argument is provided" do
                it "returns the min (assumes Comparable) n elements" do
                    ret = @nums.min(2)
                    expect(ret).to eq([1,2])
                end
            end
            context "and no argument is provided" do
                it "returns the min element (assumes Comparable)" do
                    ret = @nums.min
                    expect(ret).to eq(1)
                end
            end
        end
        context "when a block is provided" do
            context "and an argument is provided" do
                it "uses the block to return the min n elements" do
                    ret = @nums.min(2) {|a,b| -a <=> -b}
                    expect(ret).to eq([3,2])
                end
            end
            context "and no argument is provided" do
                it "uses the block to return the min element" do
                    ret = @nums.min {|a,b| -a <=> -b}
                    expect(ret).to eq(3)
                end
            end
        end
    end

    describe "#min_by" do
        context "when no argument is provided" do
            it "returns the element that gives the min block value" do
                ret = @nums.min_by {|e| e + 2*(e%2)}
                expect(ret).to eq(2)
            end 
        end 
        context "when an argument is provided" do
            it "returns the elements yielding the min n block values" do
                ret = @nums.min_by(2) {|e| -e}
                expect(ret).to eq([3,2])
            end
        end
    end

    describe "#minmax" do
        context "when no block is provided" do
            it "returns an array of the min and max values (assumes Comparable)" do
                ret = @nums.minmax
                expect(ret).to eq([1,3])
            end
        end
        context "when a block is provided" do
            it "returns an array of the min and max values using the block to compare" do
                ret = @nums.minmax {|a,b| -a <=> -b}
                expect(ret).to eq([3,1])
            end
        end
    end

    describe "#minmax_by" do
        it "returns an array of the elements yielding the min and max values from the block" do
            ret = @nums.minmax_by {|e| -e}
            expect(ret).to eq([3,1])
        end
    end

    describe "#none?" do
        context "when a block is provided" do
            it "returns true if no element causes the block to be true" do
                ret = @nums.none? {|e| e < 1}
                expect(ret).to be true
            end
            it "returns false if an element causes the block to be true" do
                ret = @nums.none? {|e| e == 2}
                expect(ret).to be false
            end
        end
        context "when no block is provided" do
            it "returns true if no element is truthy" do
                ret = @allfalsey.none?
                expect(ret).to be true
            end
            it "returns false if an element is truthy" do
                ret = @truenil.none?
                expect(ret).to be false
            end
        end
    end

    describe "#one?" do
        context "when a block is provided" do
            it "returns true if exactly one element causes the block to be true" do
                ret = @truenil.one? {|e| e == nil}
                expect(ret).to be true
            end
            it "returns false if no elements cause the block to be true" do
                ret = @allfalsey.one? {|e| e}
                expect(ret).to be false
            end
            it "returns false if more than one element causes the block to be true" do
                ret = @truenil.one? {|e| e}
                expect(ret).to be false
            end
        end
        context "when no block is provided" do
            it "returns true if exactly one element is truthy" do
                t = Triple.new(false,true,false)
                ret = t.one?
                expect(ret).to be true
            end
            it "returns false if no elements are truthy" do
                ret = @allfalsey.one?
                expect(ret).to be false
            end
            it "returns false if more than one element is truthy" do
                ret = @truenil.one?
                expect(ret).to be false
            end
        end
    end

    describe "#partition" do
        it "returns two arrays, one with those that make the block true, the others false" do
            ret = @nums.partition {|e| e == 2}
            expect(ret).to eq([[2],[1,3]])
        end
    end

    describe "#reject" do
        it "returns an array of elements that make the block false" do
            ret = @nums.reject {|e| e == 2}
            expect(ret).to eq([1,3])
        end
    end

    describe "#reverse_each" do
        it "iterates through the elements in reverse order" do
            ret = []
            @nums.reverse_each {|e| ret << e}
            expect(ret).to eq([3,2,1])
        end
    end

    describe "#select" do
        it "returns an array of all elements for which the block is true" do
            ret = @nums.select {|e| e == 2}
            expect(ret).to eq([2])
        end
    end

    describe "#slice_after" do
        context "when an argument is provided" do
            it "slices the array after each element matching the pattern" do
                t = Triple.new("str", 5, false)
                ret = t.slice_after(Integer)
                expect(ret).to match_array([["str", 5], [false]])
            end
        end
        context "when a block is provided" do
            it "slices the array after each element that makes the block true" do
                ret = @nums.slice_after {|e| e == 2}
                expect(ret).to match_array([[1,2],[3]])
            end
        end
    end

    describe "#slice_before" do
        context "when an argument is provided" do
            it "slices the array before each element matching the pattern" do
                t = Triple.new("str", 5, false)
                ret = t.slice_before(Integer)
                expect(ret).to match_array([["str"], [5, false]])
            end
        end
        context "when a block is provided" do
            it "slices the array before each element that makes the block true" do
                ret = @nums.slice_before {|e| e == 2}
                expect(ret).to match_array([[1],[2,3]])
            end
        end
    end

    describe "#slice_when" do
        it "slices when the block says to" do
            ret = @nums.slice_when {|before, after| before+after == 5}
            expect(ret).to match_array([[1,2],[3]])
        end
    end

    describe "#sort" do
        context "when no block is provided" do
            it "sorts the elements" do
                ret = @jumbled.sort
                expect(ret).to eq([1,2,3])
            end
        end
        context "when a block is provided" do
            it "uses the block to sort the elements" do
                ret = @jumbled.sort {|a,b| b <=> a}
                expect(ret).to eq([3,2,1])
            end
        end
    end

    describe "#sort_by" do
        it "sorts the elements by the block results" do
            ret = @jumbled.sort_by {|e| -e}
            expect(ret).to eq([3,2,1])
        end
    end

    describe "#sum" do
        context "when an argument is provided" do
            context "and no block is provided" do
                it "sums the list and the argument" do
                    ret = @nums.sum(2)
                    expect(ret).to eq(8)
                end
                it "uses the general add" do
                    ret = Triple.new("a","b","c").sum('')
                    expect(ret).to eq("abc")
                end
            end
            context "and a block is provided" do
                it "sums the block results and the argument" do
                    ret = @nums.sum(7) {|e| e+1}
                    expect(ret).to eq(16)
                end
            end
        end
        context "when no argument is provided" do
            context "and no block is provided" do
                it "sums the list" do
                    ret = @nums.sum
                    expect(ret).to eq(6)
                end
            end
            context "and a block is provided" do
                it "sums the block results" do
                    ret = @nums.sum {|e| e-1}
                    expect(ret).to eq(3)
                end
            end
        end
    end

    describe "#take" do
        it "returns the first n elements" do
            ret = @nums.take(2)
            expect(ret).to eq([1,2])
        end

        it "returns everything if n is too large" do
            ret = @nums.take(5)
            expect(ret).to eq([1,2,3])
        end
    end

    describe "#take_while" do
        it "takes until the block returns a falsey value" do
            ret = @truenil.take_while {|e| e}
            expect(ret).to eq([true,true])
        end
    end

    describe "#to_a" do
        it "returns an array of the elements" do
            ret = @nums.to_a
            expect(ret).to eq([1,2,3])
        end
    end

    describe "#to_h" do
        it "returns a hash, interpreting the elements as key/value pairs" do
            t = Triple.new([1,2],[2,3],[3,4])
            ret = t.to_h
            expect(ret).to eq({1 => 2, 2 => 3, 3 => 4})
        end
    end

    describe "#uniq" do
        context "when no block is provided" do
            it "returns an array with duplicates removed" do
                ret = @truenil.uniq
                expect(ret).to eq([true,nil])
            end
        end
        context "when a block is provided" do
            it "uniques the elements using the block output" do
                ret = @nums.uniq {|e| e%2}
                expect(ret).to eq([1,2])
            end
        end
    end

    describe "#zip" do
        context "when no block is provided" do
            it "zips with the arguments" do
                ret = @nums.zip(@truenil, @jumbled)
                expect(ret).to eq([[1,true,2],[2,true,1],[3,nil,3]])
            end
        end
        context "when a block is provided" do
            it "passes the zips to the block" do
                ret = []
                @nums.zip(@truenil, @jumbled) {|a,b,c| ret << a+c}
                expect(ret).to eq([3,3,6])
            end
        end
    end
end

