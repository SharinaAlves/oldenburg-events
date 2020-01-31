require_relative '../../lib/scraping/event_scraper'

class ScrapeJob < ApplicationJob
  queue_as :default

  def perform
    puts "Nachtleben"
    puts "Loft"
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/LoftOldenburg/events/?ref=page_internal")
    rescue => error
    puts "Amadeus"
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/amadeus.oldenburg/events/?ref=page_internal")
    rescue => error
    puts "Gesellig"
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/Gesellig.Oldenburg/events/?ref=page_internal")
    rescue => error
    puts "Cubes"
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/CubesOldenburg/events/?ref=page_internal")
    rescue => error
    puts "Studio B"
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/studiob.oldenburg/events/?ref=page_internal")
    rescue => error
    puts "Polyester"
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/PolyesterKlub/events/?ref=page_internal")
    rescue => error
    puts "Metro"
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/metrooldenburg/events/?ref=page_internal")
    rescue => error
    puts "Between the Sheets"
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/betweenthesheets.oldenburg/events/?ref=page_internal")
    rescue => error
    puts "Molkerei Klub"
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/molkereiklub/events/?ref=page_internal")
    rescue => error
    puts "umBAUbar"
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/umBAUbar/events/?ref=page_internal")
    rescue => error
    puts "Cadillac"
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/cadillac.zentrumfurjugendkultur/events/?ref=page_internal")
    rescue => error

    puts "Delete old ones"
    Event.where("date < ?", Date.today).delete_all

    puts "Done!"
  end
end
