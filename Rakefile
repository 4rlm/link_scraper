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
    austinchevrolet.not.real
    smith_acura.com/staff
    abcrepair.ca
    hertzrentals.com/review
    londonhyundai.uk/fleet
    http://www.townbuick.net/staff
    http://youtube.com/download
    www.madridinfiniti.es/collision
    www.mitsubishideals.sofake
    www.dallassubaru.com.sofake
    www.quickeats.net/contact_us
    www.school.edu/teachers
    www.www.nissancars/inventory
    www.www.toyotatown.net/staff/management
    www.www.yellowpages.com/business
  ]

  binding.pry
  scraper_obj = LinkScraper::Scrape.new(WebsCriteria.all_scrub_web_criteria)
  scraped_links = scraper_obj.scrub_urls(urls)
end
