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

  IRB.start
end


def run_link_scraper

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

  # scraper = LinkScraper::Scrape.new(WebsCriteria.all_scrub_web_criteria)
end
