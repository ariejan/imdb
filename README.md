# imdb [![Build Status](https://travis-ci.org/ariejan/imdb.png?branch=master)](https://travis-ci.org/ariejan/imdb) [![Gem Version](https://badge.fury.io/rb/imdb.png)](http://badge.fury.io/rb/imdb) [![Code Climate](https://codeclimate.com/github/ariejan/imdb.png)](https://codeclimate.com/github/ariejan/imdb) [![Dependency Status](https://gemnasium.com/ariejan/imdb.svg)](https://gemnasium.com/ariejan/imdb)

* [Documentation](http://rubydoc.info/github/ariejan/imdb/master/frames)
* [Sources](https://github.com/ariejan/imdb)
* [Issues](https://github.com/ariejan/imdb/issues)

## Description

The IMDB gem allows you to easy access publicly available data from IMDB.

## Features

IMDB currently features the following:

* Search for movies and TV series
* Retrieve the Top 250 listing
* Retrieve complete movie information
* Retrieve TV series and episode information

Read the [documentation](http://rubydoc.info/github/ariejan/imdb/master/frames) to see all
you can do with this gem.

## Examples

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

Or, you can filter the results by type where the supported types are :movie, :tv, :episode, :videogame

    i = Imdb::Search.new("Star Trek", :tv)

    i.movies.size
    #=> 42

## Installation

    gem install imdb

Or, if you're using this in a project with Bundler:

    gem 'imdb', '~> 0.8'

## Running Tests

As this gem uses content from imdb.com, the test suite uses a set of
pre-defined fixture files in `spec/fixtures`. These fixtures are
copies of imdb page used in tests. 

Run bundle install to install all dependencies, including fakeweb, which
will serve the fixture files instead of doing actual requests to imdb.com.

    $ bundle install

Next, simple run `rake` to run the entire test suite.

### Running against actual IMDB data

It's possible to run the test suite directly against imdb.com. This has 
two disadvantages:

 1. Tests will be slow
 2. Running tests often will probably get you into trouble, see Disclaimer.

    $ LIVE_TEST=true rake

If you want to run against actual imdb data, it's better to just update 
the fixture files once with up-to-date content:

    $ rake fixtures:refresh

When you run the test suite now, it will use the updated fixture files.

## Disclaimer

Neither I, nor any developer who contributed to this project, accept any kind of 
liability for your use of this library.

IMDB does not permit use of its data by third parties without their consent.

Using this library for anything other than limited personal use may result
in an IP ban to the IMDB website.

_This gem is not endorsed or affiliated with IMDB, or IMDb.com, Inc._

## Contributors

This gem is created and maintained by [Ariejan de Vroom](https://ariejan.net), with
help from lots of awesome [contributors](https://github.com/ariejan/imdb/graphs/contributors)

## License

See [MIT-LICENSE](https://github.com/ariejan/imdb/blob/master/MIT-LICENSE)
