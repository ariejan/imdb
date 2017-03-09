# encoding: utf-8

require 'spec_helper'

# This test uses "Die hard (1988)" as a testing sample:
#
#     http://akas.imdb.com/title/tt0095016/combined
#

describe 'Imdb::Movie' do
  describe 'valid movie' do
    # Get Die Hard (1988)
    subject { Imdb::Movie.new('0095016') }

    it 'finds the cast members' do
      cast = subject.cast_members
      expected_cast = [
        'Bruce Willis',
        'Bonnie Bedelia',
        'Alan Rickman',
      ]

      expect(cast).to be_an(Array)
      expect(cast).to include(*expected_cast)
    end

    it 'finds the cast characters' do
      char = subject.cast_characters
      expected_cast_characters = [
        'Karl',
        'Officer John McClane',
        'Police Detective (uncredited)',
        'Hostage',
      ]

      expect(char).to be_an(Array)
      expect(char).to include(*expected_cast_characters)
    end

    it 'associates the cast members to the characters' do
      cast = subject.cast_members
      char = subject.cast_characters
      cast_char = subject.cast_members_characters

      expect(cast_char[0]).to eq("#{cast[0]} => #{char[0]}")
      expect(cast_char[10]).to eq("#{cast[10]} => #{char[10]}")
      expect(cast_char[-1]).to eq("#{cast[-1]} => #{char[-1]}")

      cast_char = subject.cast_members_characters('as')

      expect(cast_char[1]).to eq("#{cast[1]} as #{char[1]}")
      expect(cast_char[11]).to eq("#{cast[11]} as #{char[11]}")
      expect(cast_char[-2]).to eq("#{cast[-2]} as #{char[-2]}")
    end

    it 'can get the user reviews' do
      reviews = subject.user_reviews

      expect(reviews).to be_an(Enumerator)
      expect(reviews.first.first[:title]).not_to be_blank
      expect(reviews.first.first[:rating]).to be_an(Integer)
      expect(reviews.first.first[:rating]).to be_between(0, 10)
      expect(reviews.first.first[:review]).not_to be_blank
    end

    describe 'fetching a list of imdb actor ids for the cast members' do
      it 'does not require arguments' do
        expect { subject.cast_member_ids }.not_to raise_error
      end

      it 'does not allow arguments' do
        expect { subject.cast_member_ids(:foo) }.to raise_error(ArgumentError)
      end

      it 'returns the imdb actor number for each cast member' do
        expect(subject.cast_member_ids).to match_array(%w(nm0000246 nm0000614 nm0000889 nm0000952 nm0001108 nm0001817 nm0005598 nm0033749 nm0040472 nm0048326 nm0072054 nm0094770 nm0101088 nm0112505 nm0112779 nm0119594 nm0127960 nm0142420 nm0160690 nm0162041 nm0234426 nm0236525 nm0239958 nm0278010 nm0296791 nm0319739 nm0322339 nm0324231 nm0326276 nm0338808 nm0356114 nm0370729 nm0383487 nm0416429 nm0421114 nm0441665 nm0484360 nm0484650 nm0493493 nm0502959 nm0503610 nm0504342 nm0539639 nm0546076 nm0546747 nm0662568 nm0669625 nm0681604 nm0687270 nm0688235 nm0718021 nm0731114 nm0776208 nm0793363 nm0852311 nm0870729 nm0882139 nm0902455 nm0907234 nm0924636 nm0936591 nm0958105 nm2143912 nm2476262 nm2565888))
      end
    end

    it 'returns the url to the movie trailer' do
      expect(subject.trailer_url).to be_a(String)
      expect(subject.trailer_url).to eq('http://imdb.com/video/screenplay/vi581042457/')
    end

    it 'finds the director' do
      expect(subject.director).to eq(['John McTiernan'])
    end

    it 'finds the company info' do
      expect(subject.company).to eq('Twentieth Century Fox Film Corporation')
    end

    it 'finds the genres' do
      expect(subject.genres).to match_array(%w(Action Thriller))
    end

    it 'finds the languages' do
      expect(subject.languages).to match_array(%w(English German Italian))
    end

    context 'the Dark Knight' do
      # The Dark Knight (2008)
      subject { Imdb::Movie.new('0468569') }

      it 'finds the countries' do
        expect(subject.countries).to match_array(%w(USA UK))
      end
    end

    it 'finds the length (in minutes)' do
      expect(subject.length).to eq(131)
    end

    it 'finds the plot' do
      expect(subject.plot).to eq('John McClane, officer of the NYPD, tries to save wife Holly Gennaro and several others, taken hostage by German terrorist Hans Gruber during a Christmas party at the Nakatomi Plaza in Los Angeles.')
    end

    it 'finds plot synopsis' do
      expect(subject.plot_synopsis).to match(/John McClane, a detective with the New York City Police Department, arrives in Los Angeles to attempt a Christmas reunion and reconciliation with his estranged wife Holly, who is attending a party thrown by her employer, the Nakatomi Corporation at its still-unfinished American branch office headquarters, the high-rise Nakatomi Plaza. When McClane refreshes himself from the flight in Holly's corporate room, they have an argument over the use of her maiden name, Gennero, but Holly is called away/)
    end

    it 'finds plot summary' do
      expect(subject.plot_summary).to eq("New York City Detective John McClane has just arrived in Los Angeles to spend Christmas with his wife. Unfortunatly, it is not going to be a Merry Christmas for everyone. A group of terrorists, led by Hans Gruber is holding everyone in the Nakatomi Plaza building hostage. With no way of anyone getting in or out, it's up to McClane to stop them all. All 12!")
    end

    it 'finds the poster' do
      expect(subject.poster).to eq('http://ia.media-imdb.com/images/M/MV5BMTY4ODM0OTc2M15BMl5BanBnXkFtZTcwNzE0MTk3OA@@.jpg')
    end

    it 'finds the rating' do
      expect(subject.rating).to eq(8.3)
    end
    
    it 'finds the metascore' do
      expect(subject.metascore).to eq(70)
    end
    
    it 'finds number of votes' do
      expect(subject.votes).to be_within(10_000).of(420_900)
    end

    it 'finds the title' do
      expect(subject.title).to match(/Die Hard/)
    end

    it 'finds the tagline' do
      expect(subject.tagline).to match(/It will blow you through the back wall of the theater/)
    end

    it 'finds the year' do
      expect(subject.year).to eq(1988)
    end

    describe 'special scenarios' do

      context 'The Matrix Revolutions' do
        # The Matrix Revolutions (2003)
        subject { Imdb::Movie.new('0242653') }
        it 'finds multiple directors' do
          expect(subject.director).to match_array(%w(Lana\ Wachowski Andy\ Wachowski))
        end
      end

      context 'Waar' do
        # Waar (2013)
        subject { Imdb::Movie.new('1821700') }
        it 'finds writers' do
          expect(subject.writers).to eq(['Hassan Waqas Rana'])
        end
      end
    end

    it 'finds multiple filming locations' do
      filming_locations = subject.filming_locations
      expect(filming_locations).to be_an(Array)
      expect(filming_locations.size).to eq(4)
      expect(filming_locations[0]).to match(/.*, USA$/i)
    end

    it "finds multiple 'also known as' versions" do
      also_known_as = subject.also_known_as
      expect(also_known_as).to be_a(Array)
      expect(also_known_as.size).to eql(40)
    end

    it "finds a specific 'also known as' version" do
      expect(subject.also_known_as).to include(version: 'Russia', title: 'Крепкий орешек')
    end

    context 'Star Trek: TOS' do
      subject { Imdb::Movie.search('Star Trek: TOS') }
      it 'provides a convenience method to search' do
        expect(subject).to respond_to(:each)
        subject.each { |movie| expect(movie).to be_an_instance_of(Imdb::Movie) }
      end
    end

    context 'top 250 Movies' do
      subject { Imdb::Movie.top_250 }
      it 'provides a convenience method to top 250' do
        expect(subject).to respond_to(:each)
        subject.each { |movie| expect(movie).to be_an_instance_of(Imdb::Movie) }
      end
    end
  end

  describe 'plot' do
    context 'Biography of Mohandas K. Gandhi' do
      subject { Imdb::Movie.new('0083987') }
      it 'finds a correct plot when HTML links are present' do
        expect(subject.plot).to eq('Biography of Mohandas K. Gandhi, the lawyer who became the famed leader of the Indian revolts against the British rule through his philosophy of nonviolent protest.')
      end
    end

    context 'movie 0036855' do
      subject { Imdb::Movie.new('0036855') }
      it "does not have a 'more' link in the plot" do
        expect(subject.plot).to eq('Years after her aunt was murdered in her home, a young woman moves back into the house with her new husband. However, he has a secret which he will do anything to protect, even if that means driving his wife insane.')
      end
    end
  end

  describe 'mpaa rating' do
    context 'movie 0111161' do
      subject { Imdb::Movie.new('0111161') }
      it 'finds the mpaa rating when present' do
        expect(subject.mpaa_rating).to eq('Rated R for language and prison violence (certificate 33087)')
      end
    end

    context 'movie 0095016' do
      subject { Imdb::Movie.new('0095016') }
      it 'is nil when not present' do
        expect(subject.mpaa_rating).to be_nil
      end
    end
  end

  describe 'with no submitted poster' do
    context 'Up is Down' do
      # Up Is Down (1969)
      subject { Imdb::Movie.new('1401252') }

      it 'has a title' do
        expect(subject.title(true)).to match(/Up Is Down/)
      end

      it 'has a year' do
        expect(subject.year).to eq(1969)
      end

      it 'returns nil as poster url' do
        expect(subject.poster).to be_nil
      end

      context 'movie 0111161' do
        subject { Imdb::Movie.new('0111161') }
        it 'returns the release date for movies' do
          expect(subject.release_date).to eq('14 October 1994 (USA)')
        end
      end
    end
  end

  describe 'with an old poster (no @@)' do
    context 'Pulp Fiction' do
      # Pulp Fiction (1994)
      subject { Imdb::Movie.new('0110912') }
      it 'has a poster' do
        expect(subject.poster).to eq('http://ia.media-imdb.com/images/M/MV5BMjE0ODk2NjczOV5BMl5BanBnXkFtZTYwNDQ0NDg4.jpg')
      end
    end
  end

  describe 'with title that has utf-8 characters' do
    context 'WALL-E' do
      # WALL-E
      subject { Imdb::Movie.search('Wall-E').first }

      it 'returns the proper title' do
        expect(subject.title).to eq('WALL·E (2008)')
      end
    end
  end
end
