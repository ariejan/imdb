require 'minitest_helper'

class TestImdbTitleMovie < MiniTest::Test

  def test_fetches_correct_data
    # Total Recall (1990)
    VCR.use_cassette('total_recall') do
      @title = Imdb::Title.fetch("0100802")

      assert_equal "Total Recall",  @title.title
      assert_equal "1990",          @title.year
    end
  end

end
