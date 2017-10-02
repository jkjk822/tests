require 'rspec/autorun'

describe Triple do

it 'returns true if all elements match the predicate' do
	expect(Triple.new(1, 2, 3).all? { |i| i > 0 }).to eq true
	expect(Triple.new(1, 2, 3).all? { |i| i > 1 }).to eq false
end

it 'returns true if all elements are true' do
	expect(Triple.new(true, true, true).all?).to eq true
	expect(Triple.new(false, true, true).all?).to eq false
end

it 'returns true if any of the elements match the predicate' do
	expect(Triple.new(1, 2, 3).any? { |i| i > 2 }).to eq true
	expect(Triple.new(1, 2, 3).any? { |i| i > 3 }).to eq false
end

it 'returns true if any of the elements are true' do
	expect(Triple.new(false, false, true).any?).to eq true
	expect(Triple.new(false, false, false).any?).to eq false
end

it 'chunks the elements based on a predicate' do
	expect(Triple.new(1, 2, 3).chunk { |i| i < 3 }).to match_array [[true, [1, 2]], [false, [3]]]
end

it 'chunks the elements based on predicate boundaries' do
	expect(Triple.new(1, 2, 3).chunk_while { |i, j| i + j > 3 }).to match_array [[1], [2, 3]]
end

it 'collects the items into an array after applying a function' do
	expect(Triple.new(1, 2, 3).collect { |i| i + 1 }).to match_array [2, 3, 4]
end

#it 'collects the intems into an array' do
#	expect(Triple.new(1, 2, 3).collect).to match_array [1, 2, 3]
#end

it 'collects items into an array based on a predicate' do
	expect(Triple.new(1, 2, 3).collect_concat { |i| [i, i - 1] }).to match_array [1, 0, 2, 1, 3, 2]
end

#it 'collects items into an array, but different' do
#	expect(Triple.new(1, 2, 3).collect_concat).to match_array [1, 2, 3]
#end

it 'counts the number of elements in the iterator' do
	expect(Triple.new(1, 2, 3).count).to eq 3
end

it 'counts the number of elements equal to the provided' do
	expect(Triple.new(1, 2, 3).count 2).to eq 1
end

it 'counts the number of elements that match the predicate' do
	expect(Triple.new(1, 2, 3).count { |i| i > 1 }).to eq 2
end

#it 'cycles the iterator a specified number of times' do
#	expect(Triple.new(1, 2, 3).cycle(2)).to match_array [1, 2, 3, 1, 2, 3]
#end

it 'cycles the iterator a specified number of times calling the block on each item' do
	expect(Triple.new(1, 2, 3).cycle(2) { |i| i + 1 }).to eq nil
end

it 'finds the first element which matches the predicate' do
	expect(Triple.new(1, 2, 3).detect { |i| i == 2 }).to eq 2
	expect(Triple.new(1, 2, 3).detect { |i| i == 4 }).to eq nil
end

#it 'collects the items into an array, but even more different' do
#	expect(Triple.new(1, 2, 3).detect).to match_array [1, 2, 3]
#end

it 'drops the first N objects from the enumerator' do
	expect(Triple.new(1, 2, 3).drop(2)).to match_array [3]
end

it 'drops elements while they match the predicate' do
	expect(Triple.new(1, 2, 3).drop_while { |i| i < 3 }).to match_array [3]
end

#it 'collects the items into an array, but so different' do
#	expect(Triple.new(1, 2, 3).drop_while).to match_array [1]
#end

#it 'does the window function' do
#	expect(Triple.new(1, 2, 3).each_cons(2)).to match_array [[1, 2], [2, 3]]
#end

it 'also does the window function, but also an each' do
	expect(Triple.new(1, 2, 3).each_cons(2) { |a| a }).to eq nil
end

it 'calls the block once for each element' do
	expect(Triple.new(1, 2, 3).each_entry { |i| i + 1 }).to match_array [1, 2, 3]
end

it 'continues to collect things into an array' do
	expect(Triple.new(1, 2, 3).each_entry).to match_array [1, 2, 3]
end

it 'iterates over each slice of N elements' do
	expect(Triple.new(1, 2, 3).each_slice(2)).to match_array [[1, 2], [3]]
end

it 'applies a predicate to each slice of N elements' do
	expect(Triple.new(1, 2, 3).each_slice(2) { |i| i[0] + 1 }).to eq nil
end

# Understanding happens

it 'calls the block with each element and its index' do
	data = [0, 0, 0]
	Triple.new(1, 2, 3).each_with_index { |e, i| data[i] = e + i }
	expect(data).to match_array [1, 3, 5]
end

#it 'zips each element with its index' do
#	expect(Triple.new(1, 2, 3).each_with_index).to match_array [[1, 0], [2, 1], [3, 2]]
#end

it 'iterates over all items with an arbitrary object' do
	expect(Triple.new(1, 2, 3).each_with_object([]) { |i, a| a << i + 1 }).to match_array [2, 3, 4]
end

#it 'zips the triple with an object' do
#	expect(Triple.new(1, 2, 3).each_with_object([])).to match_array [[1, []], [2, []], [3, []]]
#end

it 'return the entries' do
	expect(Triple.new(1, 2, 3).entries).to match_array [1, 2, 3]
end

it 'returns the first item for which the predicate is true' do
	expect(Triple.new(1, 2, 3).find { |i| i > 1 }).to eq 2
	expect(Triple.new(1, 2, 3).find(nil) { |i| i > 3 }).to eq nil
end

#it 'returns an enumerator' do
#	expect(Triple.new(1, 2, 3).find).to match_array [1, 2, 3]
#end

it 'finds all items which match the predicate' do
	expect(Triple.new(1, 2, 3).find_all { |i| i > 1 }).to match_array [2, 3]
end

#it 'returns another enumerator' do
#	expect(Triple.new(1, 2, 3).find_all).to match_array [1, 2, 3]
#end

it 'finds the index of the first item that matches the argument' do
	expect(Triple.new(1, 2, 3).find_index(2)).to eq 1
	expect(Triple.new(1, 2, 3).find_index(4)).to eq nil
end

it 'finds the index of the first element that matches the predicate' do
	expect(Triple.new(1, 2, 3).find_index { |i| i > 1 }).to eq 1
	expect(Triple.new(1, 2, 3).find_index { |i| i > 3 }).to eq nil
end

it 'returns the first element in the triple' do
	expect(Triple.new(1, 2, 3).first).to eq 1
end

it 'returns the first N elements of the triple' do
	expect(Triple.new(1, 2, 3).first(2)).to match_array [1, 2]
end

it 'is another name for concatenation' do
	expect(Triple.new(1, 2, 3).flat_map { |i| [i, -i] }).to match_array [1, -1, 2, -2, 3, -3]
end

#it 'returns the collection' do
#	expect(Triple.new(1, 2, 3).flat_map).to match_array [1, 2, 3]
#end

it 'greps the Triple' do
	expect(Triple.new(1, 2, 3).grep(0..2)).to match_array [1, 2]
end

it 'greps the triple and applies a block' do
	expect(Triple.new(1, 2, 3).grep(0..2) { |i| i + 1 }).to match_array [2, 3]
end

it 'invert greps the Triple' do
	expect(Triple.new(1, 2, 3).grep_v(0..2)).to match_array [3]
end

it 'invert greps the triple and applies a block' do
	expect(Triple.new(1, 2, 3).grep_v(0..2) { |i| i + 1 }).to match_array [4]
end

it 'groups the elements by a predicate' do
	expect(Triple.new(1, 2, 3).group_by { |i| i%2 }).to match_array [[1, [1, 3]], [0, [2]]]
end

#it 'groups the elements of the enumerable' do
#	expect(Triple.new(1, 2, 3).group_by).to match_array [1, 2, 3]
#end

it 'returns true if any member of the Triple equals the argument' do
	expect(Triple.new(1, 2, 3).include? 2).to eq true
	expect(Triple.new(1, 2, 3).include? 4).to eq false
end

#it 'it is an alias to reduce' do
#	expect(Triple.new(1, 2, 3).inject(1, :*)).to eq 6
#end

#it 'is still an alias to reduce' do
#	expect(Triple.new(1, 2, 3).inject(:+)).to eq 6
#end

it 'is more aliases to reduce' do
	expect(Triple.new(1, 2, 3).inject(2) { |m, i| m + i }).to eq 8
end

it 'this is reduce, people' do
	expect(Triple.new(1, 2, 3).inject { |m, i| m + 2 * i }).to eq 11
end

it 'maps items to new values' do
	expect(Triple.new(1, 2, 3).map { |i| i**2 }).to match_array [1, 4, 9]
end

#it 'sort of just returns the array' do
#	expect(Triple.new(1, 2, 3).map).to match_array [1, 2, 3]
#end

it 'returns the maximum item in the Triple' do
	expect(Triple.new(1, 2, 3).max).to eq 3
	expect(Triple.new(1, 2, 3).max(2)).to eq [3, 2]
end

it 'returns the max item in the array, with comparison defined by a predicate' do
	expect(Triple.new(1, 2, 3).max { |a, b| -a <=> -b }).to eq 1
	expect(Triple.new(1, 2, 3).max(2) { |a, b| -a <=> -b }).to eq [1, 2]
end

it 'returns the max item, defined by a predicate' do
	expect(Triple.new(1, 2, 3).max_by { |i| -i }).to eq 1
	expect(Triple.new(1, 2, 3).max_by(2) { |i| -i }).to eq [1, 2]
end

#it 'returns the maximum items in the array, but also just the array' do
#	expect(Triple.new(1, 2, 3).max_by).to match_array [1, 2, 3]
#	expect(Triple.new(1, 2, 3).max_by(2)).to match_array [1, 2, 3]
#end

it 'is the same as include' do
	expect(Triple.new(1, 2, 3).member?(2)).to eq true
	expect(Triple.new(1, 2, 3).member?(4)).to eq false
end

it 'returns the min item in the array, with comparison defined by a predicate' do
	expect(Triple.new(1, 2, 3).min { |a, b| -a <=> -b }).to eq 3
	expect(Triple.new(1, 2, 3).min(2) { |a, b| -a <=> -b }).to eq [3, 2]
end

it 'returns the min item, defined by a predicate' do
	expect(Triple.new(1, 2, 3).min_by { |i| -i }).to eq 3
	expect(Triple.new(1, 2, 3).min_by(2) { |i| -i }).to eq [3, 2]
end

it 'returns the minimum and maximum items in the array' do
	expect(Triple.new(1, 2, 3).minmax).to eq [1, 3]
end

it 'returns the minimum and maximum items in the array, comparison defined by a predicate' do
	expect(Triple.new(1, 2, 3).minmax { |a, b| -a <=> -b }).to eq [3, 1]
end

it 'returns the min and max as defined by a predicate' do
	expect(Triple.new(1, 2, 3).minmax_by { |i| -i }).to eq [3, 1]
end

#it 'returns the min and max, but also the whole Triple' do
#	expect(Triple.new(1, 2, 3).minmax_by).to match_array [1, 2, 3]
#end

it 'returns true if none of the items are true' do
	expect(Triple.new(true, true, true).none?).to eq false
	expect(Triple.new(false, false, false).none?).to eq true
end

it 'returns true if none of the items match the predicate' do
	expect(Triple.new(1, 2, 3).none? { |i| i > 2 }).to eq false
	expect(Triple.new(1, 2, 3).none? { |i| i > 3 }).to eq true
end

it 'returns true if and only if one item is true' do
	expect(Triple.new(true, true, false).one?).to eq false
	expect(Triple.new(false, true, false).one?).to eq true
end

it 'returns true if exactly one item matches the predicate' do
	expect(Triple.new(1, 2, 3).one? { |i| i > 1 }).to eq false
	expect(Triple.new(1, 2, 3).one? { |i| i == 2 }).to eq true
end

it 'splits the Triple into two depending on the predicate' do
	expect(Triple.new(1, 2, 3).partition { |i| i % 2 == 0 }).to match_array [[2], [1, 3]]
end

#it 'partitions the array into itself' do
#	expect(Triple.new(1, 2, 3).partition).to match_array [1, 2, 3]
#end

it 'combines all elements of the Triple' do
	expect(Triple.new(1, 2, 3).reduce(:+)).to eq 6
	expect(Triple.new(1, 2, 3).reduce(2, :+)).to eq 8
end

#it 'combines allelements of the Triple using a block' do
#	expect(Triple.new(1, 2, 3).reduce { |a, i| a + 2 * i }).to eq 11
#	expect(Triple.new(1, 2, 3).reduce(1) { |a, i| a + 2 * i }).to eq 13
#end

it 'returns all items in the triple for which the predicate does not hold' do
	expect(Triple.new(1, 2, 3).reject { |i| i > 2 }).to match_array [1, 2]
end

#it 'returns all items of the triple, but also reduced' do
#	expect(Triple.new(1, 2, 3).reject).to match_array [1, 2, 3]
#end

#it 'is the same as each, but reversed' do
#	data = []
#	expect(Triple.new(1, 2, 3).reverse_each { |i| data << i + 1}).to match_array [1, 2, 3]
#	expect(data).to match_array [4, 3, 2]
#end

#it 'returns the Triple as an array, but also doing stuff in reverse' do
#	expect(Triple.new(1, 2, 3).reverse_each).to match_array [1, 2, 3]
#end

it 'returns an array with all elements that match the predicate' do
	expect(Triple.new(1, 2, 3).select { |i| i > 2 }).to match_array [3]
end

#it 'returns all true elements in the array, but also the whole Triple' do
#	expect(Triple.new(false, true, false).select).to match_array [false, true, false]
#end

#it 'breaks the Triple into slices based on a pattern (after)' do
#	expect(Triple.new(1, 2, 3).slice_after(2..3)).to match_array [[1, 2], [3]]
#end

it 'breaks the Triple into slices based on the predicate (after)' do
	expect(Triple.new(1, 2, 3).slice_after { |i| i > 1 }).to match_array [[1, 2], [3]]
end

#it 'breaks the Triple into slices based on a pattern (before)' do
#	expect(Triple.new(1, 2, 3).slice_before(1..2)).to match_array [[1], [2, 3]]
#end

it 'breaks the Triple into slices based on the predicate (before)' do
	expect(Triple.new(1, 2, 3).slice_before { |i| i > 2 }).to match_array [[1, 2], [3]]
end

it 'breaks the Triple into slices based on a predicate' do
	expect(Triple.new(1, 2, 3).slice_when { |a,b| a + b == 3 }).to match_array [[1], [2, 3]]
end

it 'sorts the Triple' do
	expect(Triple.new(1, 3, 2).sort).to match_array [1, 2, 3]
end

it 'sorts the Triple with a block as the comparison' do
	expect(Triple.new(1, 3, 2).sort { |a, b| -a <=> -b }).to match_array [3, 2, 1]
end

it 'sorts the Triple based on a predicate' do
	expect(Triple.new(1, 3, 2).sort_by { |i| -i }).to match_array [3, 2, 1]
end

#it 'sorts the array, but also does not' do
#	expect(Triple.new(1, 3, 2).sort_by).to match_array [1, 3, 2]
#end

it 'sums the items in the Triple' do
	expect(Triple.new(1, 2, 3).sum).to eq 6
end

it 'sums the items in the Triple after applying a predicate' do
	expect(Triple.new(1, 2, 3).sum { |i| i*2 }).to eq 12
end

it 'returns the first N elements from the Triple' do
	expect(Triple.new(1, 2, 3).take(2)).to match_array [1, 2]
end

it 'returns elements while the predicate is true' do
	expect(Triple.new(1, 2, 3).take_while { |i| i < 3 }).to match_array [1, 2]
end

#it 'returns some items, but also just one' do
#	expect(Triple.new(1, 2, 3).take_while).to match_array [1]
#end

it 'turns the Triple into an array' do
	expect(Triple.new(1, 2, 3).to_a).to match_array [1, 2, 3]
end

#to_h turns pairs into a hash table
#it 'turns the Triple into key-value pairs' do
#	expect(Triple.new(1, 2, 3).each_with_index.to_h).to match_array [[1, 0], [2, 1], [3, 2]]
#end

it 'removes duplicate items in the Triple' do
	expect(Triple.new(1, 1, 3).uniq).to match_array [1, 3]
end

#it 'removes duplicate items based on a predicate' do
#	expect(Triple.new(1, 3, 2).uniq { |i| i % 2 }).to match_array [1, 2]
#end

it 'zips the Triple with another enumerable' do
	expect(Triple.new(1, 2, 3).zip([3, 2, 1])).to match_array [[1, 3], [2, 2], [3, 1]]
end

it 'zips the Triple with another enumerable, applying a block for each step' do
	data = []
	expect(Triple.new(1, 2, 3).zip([3, 2, 1]) { |a, b| data << a + b }).to eq nil
	expect(data).to match_array [4, 4, 4]
end

end
