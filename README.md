# imdb [![Build Status](https://travis-ci.org/ariejan/imdb.png?branch=master)](https://travis-ci.org/ariejan/imdb)

* [Sources](https://github.com/ariejan/imdb)
* [Issues](https://github.com/ariejan/imdb/issues)

## Description

This gem allows you to easy access publicly available data from IMDB.

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

### Using the command line utility is quite easy:

    $ imdb Star Trek

or get movie info

    $ imdb 0095016

## Installation

    gem install imdb

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

## License

See [MIT-LICENSE](https://github.com/ariejan/imdb/blob/master/MIT-LICENSE)
