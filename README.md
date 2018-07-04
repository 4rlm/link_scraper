# LinkScraper

[![Gem Version](https://badge.fury.io/rb/link_scraper.svg)](https://badge.fury.io/rb/link_scraper)
[![MIT License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

#### Scrape website links' text and path with built-in scrubbing filter.  

Designed to rapidly visit and scrape links from list of several URLs, then filters them based on your criteria.  For example, to only grab the links for inventory, staff, or contact us, etc.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'link_scraper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install link_scraper

## Usage

This is an example of how to grab links from a URL.  `args` are optional if you want to scrub and filter the links based on your criteria, like below.

```
text_criteria = {
  pos_criteria: ['coordinates', 'zip codes', 'area codes', 'climate', 'demographics'],
  neg_criteria: %w[drought school]
}

path_criteria = {
  pos_criteria: ['coordinates', 'zip codes', 'area codes', 'climate', 'demographics'],
  neg_criteria: %w[drought school]
}

scraper = LinkScraper::Scrape.new({text_criteria: text_criteria, path_criteria: path_criteria})
scraped_links = scraper.start('https://en.wikipedia.org/wiki/Austin%2C_Texas')
```

Example without Criteria (returns all links)

```
scraper = LinkScraper::Scrape.new
scraped_links = scraper.start('https://en.wikipedia.org/wiki/Austin%2C_Texas')
```

Returns Array of Links Based on Criteria in `args`:

```
[
  {:text=>"coordinates", :path=>"/wiki/geographic_coordinate_system"},
  {:text=>"2.2 climate", :path=>""},
  {:text=>"3 demographics", :path=>""},
  {:text=>"explanation", :path=>"/wiki/template:climate_chart/how_to_read_a_climate_chart"},
  {:text=>"humid subtropical climate", :path=>"/wiki/humid_subtropical_climate"},
  {:text=>"kppen climate classification", :path=>"/wiki/k%c3%b6ppen_climate_classification"},
  {:text=>"climate", :path=>""},
  {:text=>"austin climate summary", :path=>"/web/20110606123855/http://www.srh.noaa.gov/images/ewx/aus/ausclisum.pdf"},
  {:text=>"u.s. climate data", :path=>""},
  {:text=>"nowdata - noaa online weather data", :path=>"/climate/xmacis.php"},
  {:text=>"austin weather & climate", :path=>"/web/20070118231257/http://austin.about.com/od/weatherenvironment/a/weather.htm"},
  {:text=>"nowdata - noaa online weather data", :path=>"/climate/xmacis.php"},
  {:text=>"wmo climate normals for austin/municipal ap tx 19611990", :path=>"pub/gcos/wmo-normals/tables/reg_iv/us/group3/72254.txt"},
  {:text=>"climate", :path=>"/wiki/climate_of_texas"},
  {:text=>"demographics", :path=>"/wiki/demographics_of_texas"},
  {:text=>"coordinates on wikidata", :path=>"/wiki/category:coordinates_on_wikidata"}
 ]

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/link_scraper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LinkScraper project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/link_scraper/blob/master/CODE_OF_CONDUCT.md).
