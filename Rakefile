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
  binding.pry

  IRB.start
end


def run_link_scraper

  pos_texts = ["home", "team", "blog", "testimonials", "employment", "job", "contact us", "customer service", "staff"]
  neg_texts = %w[facebook commercial twit click 404 google]

  pos_paths = ["home", "team", "blog", "testimonials", "employment", "job", "contact us", "customer service", "staff"]
  neg_paths = %w[facebook commercial twit click 404 google]

  text_criteria = { pos_criteria: pos_texts, neg_criteria: neg_texts }
  path_criteria = { pos_criteria: pos_paths, neg_criteria: neg_paths }
  args = { text_criteria: text_criteria, path_criteria: path_criteria }
  scraper = LinkScraper::Scrape.new(args)
  scraped_links = scraper.start('https://www.baierltoyota.com')
  binding.pry


  # urls = %w[
  #   https://www.baierltoyota.com
  #   https://www.coleautomotive.com
  #   https://www.fairwaymazda.com
  #   https://www.olympianissan.com
  #   https://www.pomocochryslerjeepdodge.com
  #   https://www.hanseltoyota.com
  #   https://www.onioncreekvw.com
  #   https://www.jaguar.niello.com
  #   http://www.palmspringsnissan.com
  #   https://www.hebertstandc.com
  # ]

  # scraper = LinkScraper::Scrape.new(WebsCriteria.all_scrub_web_criteria)
end
