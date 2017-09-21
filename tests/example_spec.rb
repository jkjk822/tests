require 'rspec/autorun'

describe 'all?' do
	before(:example) do
		@test = Triple.new(1, 2, 3)
	end
	it 'returns true' do
		expect(@test.all? { |x| x >= 1}).to eq true
	end
	it 'returns false' do
		expect(@test.all? { |x| x == 1}).to eq false
	end
end
