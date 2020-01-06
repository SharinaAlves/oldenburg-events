class ScrapeJob < ApplicationJob
  queue_as :default

  def perform
    #EventScraper.new.scrape_partys
    #EventScraper.new.scrape_facebook
    puts "Done!"
  end
end
