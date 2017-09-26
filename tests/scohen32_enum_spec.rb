require "rspec/autorun"

RSpec.describe Triple do
    args = [1, 2, 3]
    context "initialized with #{args}" do
        subject {Triple.new(*args)}

        describe '#each' do
            it 'yields the three arguments in order' do
                expect {|b| subject.each(&b)}.to yield_successive_args(*args)
            end
        end

        describe '#all?' do
            context 'given no block' do
                it "returns whether #{args} are all truthy" do
                    expect(subject.all?).to be true
                end
            end

            context 'given an appropriate block' do
                it "returns whether #{args} are all Numeric" do
                    expect(subject.all? {|itm| itm.is_a?(Numeric)}).to be true
                end

                it "returns whether #{args} are all #{args[0]}" do
                    expect(subject.all? {|itm| itm == args[0]}).to be false
                end
            end
        end

        describe '#any?' do
            context 'given no block' do
                it "returns whether any of #{args} is truthy" do
                    expect(subject.any?).to be true
                end
            end

            context 'given an appropriate block' do
                it "returns whether any of #{args} is #{args[0]}" do
                    expect(subject.any? {|itm| itm == args[0]}).to be true
                end

                it "returns whether any of #{args} is nil" do
                    expect(subject.any? {|itm| itm == nil}).to be false
                end
            end
        end

        describe '#chunk' do
            it "groups #{args} by whether they are equal to #{args[0]}" do
                expect {|b| subject.chunk {|itm| itm == args[0]}.each(&b)}
                    .to yield_successive_args([true, [args[0]]], [false, args[1..2]])
            end

            it "omits items for which the block returns nil" do
                expect {|b| subject.chunk {|itm| itm == args[1] ? nil : true}.each(&b)}
                    .to yield_successive_args([true, [args[0]]], [true, [args[2]]])
            end

            it "omits items for which the block returns :_separator" do
                expect {|b| subject.chunk {|itm| itm == args[1] ? :_separator : true}.each(&b)}
                    .to yield_successive_args([true, [args[0]]], [true, [args[2]]])
            end

            it "returns in their own groups items for which the block returns :_alone" do
                expect {|b| subject.chunk {|itm| :_alone}.each(&b)}
                    .to yield_successive_args([:_alone, [args[0]]], [:_alone, [args[1]]], [:_alone, [args[2]]])
            end
        end

        describe '#chunk_while' do
            it 'divides the list into groups, splitting where the block returns false' do
                expect {|b| subject.chunk_while {|x, y| true unless y == args[1]}.each(&b)}
                    .to yield_successive_args([args[0]], args[1..2])
            end

            it 'returns a single group if the block always returns true' do
                expect {|b| subject.chunk_while {|x, y| true}.each(&b)}
                    .to yield_successive_args(args)
            end

            it 'returns three singleton groups if the block always returns false' do
                expect {|b| subject.chunk_while {|x, y| false}.each(&b)}
                    .to yield_successive_args([args[0]], [args[1]], [args[2]])
            end
        end

        describe '#collect' do
            it 'returns the result of applying the block to each element of the collection' do
                expect(subject.collect {|itm| "itm = #{itm}"}).to match_array [
                    "itm = #{args[0]}",
                    "itm = #{args[1]}",
                    "itm = #{args[2]}"
                ]
            end
        end

        describe '#collect_concat' do
            it 'returns the concatenation of the arrays returned by calling the block on each element' do
                expect(subject.collect_concat {|itm| [itm, itm]}).to match_array [
                    args[0], args[0],
                    args[1], args[1],
                    args[2], args[2]
                ]
            end
        end

        describe '#count' do
            context 'given no arguments and no block' do
                it 'returns the number of items in the collection' do
                    expect(subject.count).to eq 3
                end
            end

            context 'given an argument' do
                it 'returns the number of items in the collection equalling the argument' do
                    expect(subject.count(1)).to eq 1
                end

                it 'returns 0 if no items in the collection equal the argument' do
                    expect(subject.count(-1)).to eq 0
                end
            end

            context 'given a block' do
                it 'returns the number of items in the collection for which the block returns true' do
                    expect(subject.count {|itm| itm != 3}).to eq 2
                end
            end

            context 'given an argument and a block' do
                it 'uses the argument' do
                    expect(subject.count(1) {|itm| itm != 3}).to eq 1
                end

                it 'emits a warning' do
                    expect {subject.count(1) {|itm| itm != 3}}.to output(/warning: given block not used/).to_stderr
                end
            end
        end

        describe '#cycle' do
            context 'given a positive integer argument, n' do
                it 'loops through the contents of the collection once for n = 1' do
                    expect {|b| subject.cycle(1, &b)}.to yield_successive_args(*args)
                end

                it 'loops through the contents of the collection twice for n = 2' do
                    expect {|b| subject.cycle(2, &b)}.to yield_successive_args(*(args * 2))
                end
            end

            context 'given a non-positive integer argument' do
                it 'does nothing' do
                    expect {|b| subject.cycle(0, &b)}.not_to yield_control
                end
            end

            #I'm going to assume I'm not expected to test the "loops infinitely" condition of cycle, since that's
            #the halting problem
        end

        describe '#detect' do
            context 'given no arguments' do
                it 'returns the first element for which the block returns true' do
                    expect(subject.detect {|itm| true}).to eq args[0]
                end

                it 'returns nil if the block returns false for all elements' do
                    expect(subject.detect {|itm| false}).to be_nil
                end
            end

            context 'given a lambda as an argument' do
                it 'returns the first element for which the block returns true' do
                    expect(subject.detect(->() {-1}) {|itm| true}).to eq args[0]
                end

                it 'returns the result of the lambda if the block returns false for all elements' do
                    expect(subject.detect(->() {-1}) {|itm| false}).to eq(-1)
                end
            end
        end

        describe '#drop' do
            context 'given an argument n' do
                it 'returns an array of the elements sans the first n' do
                    expect(subject.drop(1)).to match_array(args[1..2])
                end
            end

            context 'given no arguments' do
                it 'raises an ArgumentError' do
                    expect {subject.drop}.to raise_error(ArgumentError)
                end
            end
        end

        describe '#drop_while' do
            it 'returns an array of elements starting from the first element for which the block returns false' do
                expect(subject.drop_while {|itm| itm == args[0]}).to match_array(args[1..2])
            end
        end

        describe '#each_cons' do
            context 'given an argument n' do
                it 'iterates through each sublist of n consecutive elements, allowing for overlap' do
                    expect {|b| subject.each_cons(2, &b)}.to yield_successive_args(args[0..1], args[1..2])
                end
            end

            context 'given no arguments' do
                it 'raises an ArgumentError' do
                    expect {subject.each_cons}.to raise_error(ArgumentError)
                end
            end
        end

        describe '#each_entry' do
            it 'iterates over all elements of the collection' do
                expect {|b| subject.each_entry(&b)}.to yield_successive_args(*args)
            end
        end

        describe '#each_slice' do
            context 'given an argument n' do
                it 'splits the elements into chunks of n elements and iterates through them, allowing for a remainder' do
                    expect {|b| subject.each_slice(2, &b)}.to yield_successive_args(args[0..1], [args[2]])
                end
            end

            context 'given no arguments' do
                it 'raises an ArgumentError' do
                    expect {subject.each_slice}.to raise_error(ArgumentError)
                end
            end
        end

        describe '#each_with_index' do
            it 'iterates over all elements of the collection along with their indexes' do
                expect {|b| subject.each_with_index(&b)}
                    .to yield_successive_args([args[0], 0], [args[1], 1], [args[2], 2])
            end
        end

        describe '#each_with_object' do
            context 'given an argument' do
                it 'iterates over each element in the collection, also yielding the argument' do
                    expect {|b| subject.each_with_object(:test, &b)}
                        .to yield_successive_args([args[0], :test], [args[1], :test], [args[2], :test])
                end
            end

            context 'given no arguments' do
                it 'raises an ArgumentError' do
                    expect {subject.each_with_object}.to raise_error(ArgumentError)
                end
            end
        end

        describe '#entries' do
            it 'returns an array of the items in the collection' do
                expect(subject.entries).to match_array(args)
            end
        end

        describe '#find' do
            context 'given no arguments' do
                it 'returns the first element for which the block returns true' do
                    expect(subject.find {|itm| true}).to eq args[0]
                end

                it 'returns nil if the block returns false for all elements' do
                    expect(subject.find {|itm| false}).to be_nil
                end
            end

            context 'given a lambda as an argument' do
                it 'returns the first element for which the block returns true' do
                    expect(subject.find(->() {-1}) {|itm| true}).to eq args[0]
                end

                it 'returns the result of the lambda if the block returns false for all elements' do
                    expect(subject.find(->() {-1}) {|itm| false}).to eq(-1)
                end
            end
        end

        describe '#find_all' do
            it 'returns an array of all elements for which the block returns true' do
                expect(subject.find_all {|itm| itm != args[0]}).to match_array(args[1..2])
            end

            it 'returns an empty array if the block returns false for all elements' do
                expect(subject.find_all {|itm| false}).to be_empty
            end
        end

        describe '#find_index' do
            context 'given an argument' do
                it 'returns the index of the first occurance of the argument in the collection' do
                    expect(subject.find_index(args[0])).to eq 0
                end

                it 'returns nil if the argument is not found in the collection' do
                    expect(subject.find_index(-1)).to be_nil
                end
            end

            context 'given a block' do
                it 'returns the index of the first element for which the block returns true' do
                    expect(subject.find_index {|itm| itm == args[1]}).to eq 1
                end

                it 'returns nil if the block returns false for all elements' do
                    expect(subject.find_index {|itm| false}).to be_nil
                end
            end

            context 'given an argument and a block' do
                it 'uses the argument' do
                    expect(subject.find_index(args[0]) {|itm| false}).to eq 0
                end

                it 'emits a warning' do
                    expect {subject.find_index(args[0]) {|itm| false}}
                        .to output(/warning: given block not used/).to_stderr
                end
            end
        end

        describe '#first' do
            context 'given no arguments' do
                it 'returns the first element of the collection' do
                    expect(subject.first).to eq args[0]
                end
            end

            context 'given an argument n' do
                it 'returns an array of the first n elements in the collection' do
                    expect(subject.first(2)).to match_array(args[0..1])
                end
            end
        end

        describe '#flat_map' do
            it 'returns the concatenation of the arrays returned by calling the block on each element' do
                expect(subject.flat_map {|itm| [itm, itm]}).to match_array [
                    args[0], args[0],
                    args[1], args[1],
                    args[2], args[2]
                ]
            end
        end

        describe '#grep' do
            context 'given a pattern argument and no block' do
                it 'returns an array of all elements in the collection matching the pattern' do
                    expect(subject.grep(args[1]..args[2])).to match_array(args[1..2])
                end
            end

            context 'given a pattern argument and a block' do
                it 'returns an array of the results of passing each collection element that matches the pattern to the block' do
                    expect(subject.grep(args[1]..args[2]) {|itm| "itm = #{itm}"}).to match_array [
                        "itm = #{args[1]}",
                        "itm = #{args[2]}"
                    ]
                end
            end

            context 'given no arguments' do
                it 'raises an ArgumentError' do
                    expect {subject.grep}.to raise_error(ArgumentError)
                end
            end
        end

        describe '#grep_v' do
            context 'given a pattern argument and no block' do
                it 'returns an array of all elements in the collection not matching the pattern' do
                    expect(subject.grep_v(args[1]..args[2])).to match_array [args[0]]
                end
            end

            context 'given a pattern argument and a block' do
                it 'returns an array of the results of passing each collection element that does not match the pattern to the block' do
                    expect(subject.grep_v(args[1]..args[2]) {|itm| "itm = #{itm}"}).to match_array ["itm = #{args[0]}"]
                end
            end

            context 'given no arguments' do
                it 'raises an ArgumentError' do
                    expect {subject.grep_v}.to raise_error(ArgumentError)
                end
            end
        end

        describe '#group_by' do
            it 'returns a hash in which the keys are all the values returned by the block and the values are arrays of all the collection elements for which the block returned each value' do
                expect(subject.group_by {|itm| itm != args[0]}).to contain_exactly(
                    [false, [args[0]]],
                    [true, args[1..2]]
                )
            end
        end

        describe '#include?' do
            context 'given an argument' do
                it 'returns true if any element in the collection equals the argument' do
                    expect(subject.include?(args[0])).to be true
                end

                it 'returns false if no element in the collection equals the argument' do
                    expect(subject.include?(-1)).to be false
                end
            end

            context 'given no arguments' do
                it 'raises an ArgumentError' do
                    expect {subject.include?}.to raise_error(ArgumentError)
                end
            end
        end

        describe '#inject' do
            context 'given a symbol argument and no block' do
                it 'reduces the collection in ascending order, initializing the accumulator with the first element and calling accumulator.send(symbol, next) to get the next value of the accumulator' do
                    expect(subject.inject(:-)).to eq args[0] - args[1] - args[2]
                end
            end

            context 'given two arguments, the second of which is a symbol' do
                it 'reduces the collection in ascending order, initializing the accumulator with the first argument and calling accumulator.send(symbol, next) to get the next value of the accumulator' do
                    expect(subject.inject(42, :-)).to eq 42 - args[0] - args[1] - args[2]
                end
            end

            context 'given no arguments and a block' do
                it 'reduces the collection in ascending order, initializing the accumulator with the first element of the collection and calling the block to get the next value of the accumulator' do
                    expect(subject.inject {|diff, itm| diff - itm}).to eq args[0] - args[1] - args[2]
                end
            end

            context 'given an argument and a block' do
                it 'reduces the collection in ascending order, initializing the accumulator with the argument and calling the block to get the next value of the accumulator' do
                    expect(subject.inject(42) {|diff, itm| diff - itm}).to eq 42 - args[0] - args[1] - args[2]
                end
            end

            context 'given no arguments and no block' do
                it 'raises a LocalJumpError' do
                    expect {subject.inject}.to raise_error(LocalJumpError)
                end
            end
        end

        describe '#map' do
            it 'returns the result of applying the block to each element of the collection' do
                expect(subject.map {|itm| "itm = #{itm}"}).to match_array [
                    "itm = #{args[0]}",
                    "itm = #{args[1]}",
                    "itm = #{args[2]}"
                ]
            end
        end

        describe '#max' do
            context 'given no arguments and no block' do
                it 'returns the max element in the collection, using <=> for comparisons' do
                    expect(subject.max).to eq 3
                end
            end

            context 'given an argument n and no block' do
                it 'returns an array of the max n elements in the collection, using <=> for comparisons' do
                    result = subject.max(2)
                    expect(result.length).to eq 2
                    expect(result).to include(2, 3)
                end
            end

            context 'given no arguments and a block' do
                it 'returns the max element in the collection, using the block for comparisons' do
                    expect(subject.max {|a, b| b <=> a}).to eq 1
                end
            end

            context 'given an argument n and a block' do
                it 'returns an array of the max n elements in the collection, using the block for comparison' do
                    result = subject.max(2) {|a, b| b <=> a}
                    expect(result.length).to eq 2
                    expect(result).to include(1, 2)
                end
            end
        end

        describe '#max_by' do
            context 'given no arguments and a block' do
                it 'returns the collection element for which the block returns the highest value' do
                    expect(subject.max_by {|itm| -itm}).to eq 1
                end
            end

            context 'given an argument n and a block' do
                it 'returns an array of the n elements for which the block gives the highest values' do
                    result = subject.max_by(2) {|itm| -itm}
                    expect(result.length).to eq 2
                    expect(result).to include(1, 2)
                end
            end
        end

        describe '#member?' do
            context 'given an argument' do
                it 'returns true if any element in the collection equals the argument' do
                    expect(subject.member?(args[0])).to be true
                end

                it 'returns false if no element in the collection equals the argument' do
                    expect(subject.member?(-1)).to be false
                end
            end

            context 'given no arguments' do
                it 'raises an ArgumentError' do
                    expect {subject.member?}.to raise_error(ArgumentError)
                end
            end
        end

        describe '#min' do
            context 'given no arguments and no block' do
                it 'returns the minimum element in the collection, using <=> for comparisons' do
                    expect(subject.min).to eq 1
                end
            end

            context 'given an argument n and no block' do
                it 'returns an array of the minimum n elements in the collection, using <=> for comparisons' do
                    result = subject.min(2)
                    expect(result.length).to eq 2
                    expect(result).to include(1, 2)
                end
            end

            context 'given no arguments and a block' do
                it 'returns the minimum element in the collection, using the block for comparisons' do
                    expect(subject.min {|a, b| b <=> a}).to eq 3
                end
            end

            context 'given an argument n and a block' do
                it 'returns an array of the minimum n elements in the collection, using the block for comparison' do
                    result = subject.min(2) {|a, b| b <=> a}
                    expect(result.length).to eq 2
                    expect(result).to include(2, 3)
                end
            end
        end

        describe '#min_by' do
            context 'given no arguments and a block' do
                it 'returns the collection element for which the block returns the smallest value' do
                    expect(subject.min_by {|itm| -itm}).to eq 3
                end
            end

            context 'given an argument n and a block' do
                it 'returns an array of the n elements for which the block gives the smallest values' do
                    result = subject.min_by(2) {|itm| -itm}
                    expect(result.length).to eq 2
                    expect(result).to include(2, 3)
                end
            end
        end

        describe '#minmax' do
            context 'given no block' do
                it 'returns an array containing the min and max collection elements, using <=> for comparison' do
                    expect(subject.minmax).to match_array [1, 3]
                end
            end

            context 'given a block' do
                it 'returns an array containing the min and max collection elements, using the block for comparsion' do
                    expect(subject.minmax {|a, b| b <=> a}).to match_array [3, 1]
                end
            end
        end

        describe '#minmax_by' do
            it 'returns an array containing the two collection elements for which the block returns the smallest and largest values' do
                expect(subject.minmax_by {|itm| -itm}).to match_array [3, 1]
            end
        end

        describe '#none?' do
            context 'given no block' do
                it 'returns true if all elements in the collection are falsey' do
                    expect(subject.none?).to be false
                end
            end

            context 'given a block' do
                it 'returns true if the block returns false for all elements' do
                    expect(subject.none? {|itm| false}).to be true
                end

                it 'returns false if the block returns true for any element' do
                    expect(subject.none? {|itm| itm == args[0]})
                end
            end
        end

        describe '#one?' do
            context 'given no block' do
                it 'returns true if exactly one element in the collection is truthy' do
                    expect(subject.one?).to be false
                end
            end

            context 'given a block' do
                it 'returns true if the block returns true for exactly one element in the collection' do
                    expect(subject.one? {|itm| itm == args[0]}).to be true
                end

                it 'returns false if the block returns false for all elements in the collection' do
                    expect(subject.one? {|itm| false}).to be false
                end

                it 'returns false if the block returns true more than once' do
                    expect(subject.one? {|itm| true}).to be false
                end
            end
        end

        describe '#partition' do
            it 'returns two arrays: the elements for which the block returned true and false, respectively' do
                expect(subject.partition {|itm| itm == args[1]}).to match_array [[args[1]], [args[0], args[2]]]
            end
        end

        describe '#reduce' do
            context 'given a symbol argument and no block' do
                it 'reduces the collection in ascending order, initializing the accumulator with the first element and calling accumulator.send(symbol, next) to get the next value of the accumulator' do
                    expect(subject.reduce(:-)).to eq args[0] - args[1] - args[2]
                end
            end

            context 'given two arguments, the second of which is a symbol' do
                it 'reduces the collection in ascending order, initializing the accumulator with the first argument and calling accumulator.send(symbol, next) to get the next value of the accumulator' do
                    expect(subject.reduce(42, :-)).to eq 42 - args[0] - args[1] - args[2]
                end
            end

            context 'given no arguments and a block' do
                it 'reduces the collection in ascending order, initializing the accumulator with the first element of the collection and calling the block to get the next value of the accumulator' do
                    expect(subject.reduce {|diff, itm| diff - itm}).to eq args[0] - args[1] - args[2]
                end
            end

            context 'given an argument and a block' do
                it 'reduces the collection in ascending order, initializing the accumulator with the argument and calling the block to get the next value of the accumulator' do
                    expect(subject.reduce(42) {|diff, itm| diff - itm}).to eq 42 - args[0] - args[1] - args[2]
                end
            end

            context 'given no arguments and no block' do
                it 'raises a LocalJumpError' do
                    expect {subject.reduce}.to raise_error(LocalJumpError)
                end
            end
        end

        describe '#reject' do
            it 'returns an array of all colletion elements for which the block returns false' do
                expect(subject.reject {|itm| itm == args[1]}).to match_array [args[0], args[2]]
            end
        end

        describe '#reverse_each' do
            it 'iterates through the elements in the collection in reverse order' do
                expect {|b| subject.reverse_each(&b)}.to yield_successive_args(*args.reverse)
            end
        end

        describe '#select' do
            it 'returns an array of all elements for which the block returns true' do
                expect(subject.select {|itm| itm != args[0]}).to match_array(args[1..2])
            end

            it 'returns an empty array if the block returns false for all elements' do
                expect(subject.select {|itm| false}).to be_empty
            end
        end

        describe '#slice_after' do
            context 'given a pattern argument and no block' do
                it 'divides the elements into groups ending with elements that match the pattern' do
                    expect {|b| subject.slice_after(args[1]).each(&b)}
                        .to yield_successive_args(args[0..1], [args[2]])
                end
            end

            context 'given no arguments and a block' do
                it 'divides the elements into groups ending with elements for which the block returns true' do
                    expect {|b| subject.slice_after {|itm| itm == args[1]}.each(&b)}
                        .to yield_successive_args(args[0..1], [args[2]])
                end
            end

            context 'given an argument and a block' do
                it 'raises an ArgumentError' do
                    expect {subject.slice_after(2) {|itm| true}}.to raise_error(ArgumentError)
                end
            end
        end

        describe '#slice_before' do
            context 'given a pattern argument and no block' do
                it 'divides the elements into groups beginning with elements that match the pattern (or are the first element)' do
                    expect {|b| subject.slice_before(args[1]).each(&b)}
                        .to yield_successive_args([args[0]], args[1..2])
                end
            end

            context 'given no arguments and a block' do
                it 'divides the elements into groups ending with elements for which the block returns true (or are the first element)' do
                    expect {|b| subject.slice_before {|itm| itm == args[1]}.each(&b)}
                        .to yield_successive_args([args[0]], args[1..2])
                end
            end

            context 'given an argument and a block' do
                it 'raises an ArgumentError' do
                    expect {subject.slice_before(2) {|itm| true}}.to raise_error(ArgumentError)
                end
            end
        end

        describe '#slice_when' do
            it 'divides the list into groups, splitting where the block returns true' do
                expect {|b| subject.slice_when {|x, y| y == args[1]}.each(&b)}
                    .to yield_successive_args([args[0]], args[1..2])
            end

            it 'returns a single group if the block always returns false' do
                expect {|b| subject.slice_when {|x, y| false}.each(&b)}
                    .to yield_successive_args(args)
            end

            it 'returns three singleton groups if the block always returns true' do
                expect {|b| subject.slice_when {|x, y| true}.each(&b)}
                    .to yield_successive_args([args[0]], [args[1]], [args[2]])
            end
        end

        describe '#sort' do
            context 'given no block' do
                it 'returns a sorted array of the elements in the collection, using <=> for comparison' do
                    expect(subject.sort).to match_array(args)
                end
            end

            context 'given a block' do
                it 'returns a sorted array of the elements in the collection, using the block for comparsion' do
                    expect(subject.sort {|a, b| b <=> a}).to match_array(args.reverse)
                end
            end
        end

        describe '#sort_by' do
            it 'returns an array of the elements in the collection sorted by the values the block returns for them' do
                expect(subject.sort_by {|itm| -itm}).to match_array(args.reverse)
            end
        end

        describe '#sum' do
            context 'given no arguments and no block' do
                it 'returns the sum of the collection elements' do
                    expect(subject.sum).to eq args[0] + args[1] + args[2]
                end
            end

            context 'given an argument and no block' do
                it 'returns the sum of the collection elements plus the argument' do
                    expect(subject.sum(42)).to eq 42 + args[0] + args[1] + args[2]
                end
            end

            context 'given no arguments and a block' do
                it 'returns the sum of the values returned by the block for each element' do
                    expect(subject.sum {|itm| itm * 2}).to eq args[0] * 2 + args[1] * 2 + args[2] * 2
                end
            end

            context 'given an argument and a block' do
                it 'returns the sum of the argument plus the values returned by the block for each element' do
                    expect(subject.sum(42) {|itm| itm * 2}).to eq 42 + args[0] * 2 + args[1] * 2 + args[2] * 2
                end
            end
        end

        describe '#take' do
            context 'given an argument n' do
                it 'returns the first n elements as an array' do
                    expect(subject.take(2)).to match_array(args[0..1])
                end
            end
        end

        describe '#take_while' do
            it 'returns an array of all collection elements until the first for which the block returns false' do
                expect(subject.take_while {|itm| itm == args[0]}).to match_array [args[0]]
            end
        end

        describe '#to_a' do
            it 'returns an array of the items in the collection' do
                expect(subject.to_a).to match_array(args)
            end
        end

        describe '#zip' do
            context 'given no block' do
                context 'and no arguments' do
                    it 'returns an array of singleton arrays containing the collection elements' do
                        expect(subject.zip).to match_array [[args[0]], [args[1]], [args[2]]]
                    end
                end

                context 'and one array argument' do
                    it 'returns the cartesian product of the collection and the argument' do
                        expect(subject.zip([0, 1, 2])).to match_array [[args[0], 0], [args[1], 1], [args[2], 2]]
                    end

                    it 'inserts nil values if the argument is shorter than the colleciton' do
                        expect(subject.zip([])).to match_array [[args[0], nil], [args[1], nil], [args[2], nil]]
                    end
                end

                context 'and multiple array arguments' do
                    it 'returns the n-fold cartesian product of the collection and all the arguments' do
                        expect(subject.zip([0, 1, 2], [3, 4, 5])).to match_array [
                            [args[0], 0, 3],
                            [args[1], 1, 4],
                            [args[2], 2, 5]
                        ]
                    end

                    it 'inserts nil values if the argument is shorter than the colleciton' do
                        expect(subject.zip([0, 1, 2], [])).to match_array [
                            [args[0], 0, nil],
                            [args[1], 1, nil],
                            [args[2], 2, nil]
                        ]
                    end
                end
            end

            context 'given a block' do
                context 'and no arguments' do
                    it 'yields the collection elements' do
                        expect {|b| subject.zip(&b)}.to yield_successive_args(*args)
                    end
                end

                context 'and one array argument' do
                    it 'yields the pairs of the cartesian product of the collection and the argument' do
                        expect {|b| subject.zip([0, 1, 2], &b)}
                            .to yield_successive_args([args[0], 0], [args[1], 1], [args[2], 2])
                    end

                    it 'inserts nil values if the argument is shorter than the colleciton' do
                        expect {|b| subject.zip([], &b)}
                            .to yield_successive_args([args[0], nil], [args[1], nil], [args[2], nil])
                    end
                end

                context 'and multiple array arguments' do
                    it 'returns the n-fold cartesian product of the collection and all the arguments' do
                        expect {|b|subject.zip([0, 1, 2], [3, 4, 5], &b)}
                            .to yield_successive_args([args[0], 0, 3], [args[1], 1, 4], [args[2], 2, 5])
                    end

                    it 'inserts nil values if the argument is shorter than the colleciton' do
                        expect {|b| subject.zip([0, 1, 2], [], &b)}
                            .to yield_successive_args([args[0], 0, nil], [args[1], 1, nil], [args[2], 2, nil])
                    end
                end
            end
        end
    end

    context 'initialized with three key-value pairs' do
        pairs = [[:a, 1], [:b, 2], [:c, 3]]
        subject {Triple.new(*pairs)}

        describe '#to_h' do
            it 'converts a collection of key-value pairs into a hash' do
                expect(subject.to_h).to contain_exactly(*pairs)
            end
        end
    end

    context 'initialized with duplicate values' do
        subject {Triple.new(1, 1, 2)}

        describe '#uniq' do
            context 'given no block' do
                it 'returns an array of only the unique elements in the collection' do
                    expect(subject.uniq).to match_array [1, 2]
                end
            end

            context 'given a block' do
                it 'returns an array omitting elements for which the block returns an already returned value' do
                    dummyRetVal = 0
                    expect(subject.uniq {|itm| itm == 1 ? dummyRetVal += 1 : 1}).to match_array [1, 1]
                end
            end
        end
    end
end
