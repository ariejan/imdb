require 'minitest_helper'

class TestImdbVersion < MiniTest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Imdb::VERSION
  end
end
