require 'minitest/autorun'

class ExampleEnumerableTests < Minitest::Test

	def setup
		@test = Triple.new(1, 2, 3)
	end

	def test_any
		assert @test.all? { |a| a >= 1 }
		refute @test.all? { |a| a == 1}
	end

end