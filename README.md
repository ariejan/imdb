# imdb [![Build Status](https://travis-ci.org/ariejan/imdb.png?branch=master)](https://travis-ci.org/ariejan/imdb)

* [Sources](https://github.com/ariejan/imdb)
* [Issues](https://github.com/ariejan/imdb/issues)

## Description

The IMDB gem allows you to easy access publicly available data from IMDB.

## Features

IMDB currently features the following:

* Querying details movie info
* Searching for movies
* Command-line utility included.

## Synopsis

### Movies:

    i = Imdb::Movie.new("0095016")

    i.title
    #=> "Die Hard"

    i.cast_members.first
    #=> "Bruce Willis"

### Series:

    serie = Imdb::Serie.new("1520211")

    serie.title
    #=> "\"The Walking Dead\""

    serie.rating
    #=> 8.8

    serie.seasons.size
    #=> 3

    serie.season(1).episodes.size
    #=> 6

    series.season(1).episode(2).title
    #=> "Guts"

### Searching:

    i = Imdb::Search.new("Star Trek")

    i.movies.size
    #=> 97

## Installation

    gem install imdb

Or, if you're using this in a project with Bundler:

    gem 'imdb', '~> 0.8'

## Running Tests

You'll need rspec and fakeweb installed to run the specs.

    $ bundle install
    $ bundle exec rake spec

Although not recommended, you may run the specs against the live imdb.com 
website. This will make a lot of calls to imdb.com, use it wisely.

    $ LIVE_TEST=true bundle exec rake spec

To update the packaged fixtures files with actual imdb.com samples, use the 
`fixtures:refresh` rake task

    $ bundle exec rake fixtures:refresh

## Disclaimer

Neither I, nor any developer who contributed to this project, accept any kind of 
liability for your use of this library.

IMDB does not permit use of its data by third parties without their consent.

Using this library for anything other than limited personal use may result
in an IP ban to the IMDB website.

_This gem is not endorsed or affiliated with IMDB, or IMDb.com, Inc._

## License

See [MIT-LICENSE](https://github.com/ariejan/imdb/blob/master/MIT-LICENSE)
