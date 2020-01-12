class ScrapeJob < ApplicationJob
  queue_as :default

  def perform
    # Nachtleben
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/LoftOldenburg/events/?ref=page_internal") # Loft
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/amadeus.oldenburg/events/?ref=page_internal") # Amadeus
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/Gesellig.Oldenburg/events/?ref=page_internal") # Gesellig
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/CubesOldenburg/events/?ref=page_internal") # Cubes
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/studiob.oldenburg/events/?ref=page_internal") # Studio B
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/PolyesterKlub/events/?ref=page_internal") # Polyester
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/metrooldenburg/events/?ref=page_internal") # Metro
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/betweenthesheets.oldenburg/events/?ref=page_internal") # Between the Sheets
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/molkereiklub/events/?ref=page_internal") # Molkerei Klub
    EventScraper.new.scrape_facebook("https://www.facebook.com/pg/umBAUbar/events/?ref=page_internal") # Umbaubar

    puts "Done!"
  end
end
