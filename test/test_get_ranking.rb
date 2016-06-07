require 'minitest/autorun'
require './lib/get_ranking'

class TestGetRanking < Minitest::Test
  def test_get_ranking
    result = get_ranking('格安SIM')
    assert_operator 95, :<=, result.count
  end
end
