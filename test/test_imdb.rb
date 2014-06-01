require 'minitest_helper'

class TestImdb < MiniTest::Unit::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::Imdb::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
