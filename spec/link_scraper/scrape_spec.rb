# rspec spec/link_scraper/scrape_spec.rb

require 'spec_helper'

describe 'Scrape' do
  let(:text_criteria) do
    { pos_criteria: ['coordinates', 'zip codes', 'area codes', 'climate', 'demographics'],
      neg_criteria: %w[drought school] }
  end

  let(:path_criteria) do
    { pos_criteria: ['coordinates', 'zip codes', 'area codes', 'climate', 'demographics'],
      neg_criteria: %w[drought school] }
  end

  let(:scrape_obj) { LinkScraper::Scrape.new(text_criteria: text_criteria, path_criteria: path_criteria) }
  let(:url) { 'https://en.wikipedia.org/wiki/Austin%2C_Texas' }

  let(:valid_links) do
    [{ text: 'coordinates', path: '/wiki/geographic_coordinate_system' },
     { text: '2.2 climate', path: '#climate' },
     { text: '3 demographics', path: '#demographics' },
     { text: 'explanation', path: '/wiki/template:climate_chart/how_to_read_a_climate_chart' },
     { text: 'humid subtropical climate', path: '/wiki/humid_subtropical_climate' },
     { text: 'kppen climate classification', path: '/wiki/k%c3%b6ppen_climate_classification' },
     { text: 'climate', path: '#climate' },
     { text: 'austin climate summary', path: 'https://web.archive.org/web/20110606123855/http://www.srh.noaa.gov/images/ewx/aus/ausclisum.pdf' },
     { text: 'u.s. climate data', path: 'http://www.usclimatedata.com' },
     { text: 'nowdata - noaa online weather data', path: 'http://www.nws.noaa.gov/climate/xmacis.php?wfo=ewx' },
     { text: 'austin weather & climate', path: 'https://web.archive.org/web/20070118231257/http://austin.about.com/od/weatherenvironment/a/weather.htm' },
     { text: 'nowdata - noaa online weather data', path: 'http://www.nws.noaa.gov/climate/xmacis.php?wfo=ewx' },
     { text: 'wmo climate normals for austin/municipal ap tx 19611990', path: 'ftp://ftp.atdd.noaa.gov/pub/gcos/wmo-normals/tables/reg_iv/us/group3/72254.txt' },
     { text: 'climate', path: '/wiki/climate_of_texas' },
     { text: 'demographics', path: '/wiki/demographics_of_texas' },
     { text: 'coordinates on wikidata', path: '/wiki/category:coordinates_on_wikidata' }]
  end

  describe '#start' do
    let(:keys) { %i[text path] }

    it 'start' do
      expect(scrape_obj.start(url).first.keys).to eql(keys)
    end
  end

  describe '#extract_link_from_url' do
    it 'extract_link_from_url' do
      expect(scrape_obj.extract_link_from_url(valid_links, url)).to eql(valid_links)
    end
  end

  describe '#scrub_link_hashes' do
    it 'scrub_link_hashes' do
      expect(scrape_obj.scrub_link_hashes(valid_links, url)).to eql(valid_links)
    end
  end

  describe '#encode_link' do
    let(:link_hsh_in) do
      { text: 'jump to navigation', path: '#mw-head' }
    end
    let(:link_hsh_out) { { text: 'jump to navigation', path: '#mw-head' } }

    it 'encode_link' do
      expect(scrape_obj.encode_link(link_hsh_in)).to eql(link_hsh_out)
    end
  end

  describe '#encoder' do
    let(:text_in) { 'jump to navigation' }
    let(:text_out) { 'jump to navigation' }

    it 'encoder' do
      expect(scrape_obj.encoder(text_in)).to eql(text_out)
    end
  end

  describe '#evaluate_scrub_hsh' do
    let(:hsh_in) do
      { string: 'jump to navigation', pos_criteria: [], neg_criteria: [] }
    end
    let(:hsh_out) { nil }

    it 'evaluate_scrub_hsh' do
      expect(scrape_obj.evaluate_scrub_hsh(hsh_in)).to eql(hsh_out)
    end
  end
end
