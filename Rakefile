require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'link_scraper'
require 'webs_criteria'


RSpec::Core::RakeTask.new(:spec)

task :default => :spec
task :test => :spec

###################
task :console do
  require 'irb'
  require 'irb/completion'
  require 'link_scraper'
  require "active_support/all"
  ARGV.clear

  scraped_links = run_link_scraper
  # binding.pry

  IRB.start
end


def run_link_scraper
  urls = %w[
    https://www.baierltoyota.com
    https://www.coleautomotive.com
    https://www.fairwaymazda.com
    https://www.olympianissan.com
    https://www.pomocochryslerjeepdodge.com
    https://www.hanseltoyota.com
    https://www.onioncreekvw.com
    https://www.jaguar.niello.com
    http://www.palmspringsnissan.com
    https://www.hebertstandc.com
  ]

  # scraper_obj = LinkScraper::Scrape.new(WebsCriteria.all_scrub_web_criteria)

  binding.pry
  args = {}
  scraper_obj = LinkScraper::Scrape.new(args)
  binding.pry
  scraped_links = scraper_obj.start(urls.first)
end
