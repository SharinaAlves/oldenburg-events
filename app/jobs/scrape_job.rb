require_relative '../../lib/scraping/event_scraper'

class ScrapeJob < ApplicationJob
  queue_as :default

  def perform
    puts "Delete old ones"
    Event.where("date < ?", Date.today).delete_all

    puts "Nachtleben"
    puts "Loft"
    begin
      EventScraper.new.scrape_facebook("https://www.facebook.com/pg/LoftOldenburg/events/?ref=page_internal", "Loft")
    rescue => error
      puts error
    end

    puts "Amadeus"
    begin
      EventScraper.new.scrape_facebook("https://www.facebook.com/pg/amadeus.oldenburg/events/?ref=page_internal", "Amadeus")
    rescue => error
      puts error
    end

    puts "Gesellig"
    begin
      EventScraper.new.scrape_facebook("https://www.facebook.com/pg/Gesellig.Oldenburg/events/?ref=page_internal", "Gesellig")
    rescue => error
      puts error
    end

    puts "Cubes"
    begin
      EventScraper.new.scrape_facebook("https://www.facebook.com/pg/CubesOldenburg/events/?ref=page_internal", "Cubes")
    rescue => error
      puts error
    end

    puts "Studio B"
    begin
      EventScraper.new.scrape_facebook("https://www.facebook.com/pg/studiob.oldenburg/events/?ref=page_internal", "Studio B")
    rescue => error
      puts error
    end

    puts "Polyester"
    begin
      EventScraper.new.scrape_facebook("https://www.facebook.com/pg/PolyesterKlub/events/?ref=page_internal", "Polyester")
    rescue => error
      puts error
    end

    puts "Metro"
    begin
      EventScraper.new.scrape_facebook("https://www.facebook.com/pg/metrooldenburg/events/?ref=page_internal", "Metro")
    rescue => error
      puts error
    end

    puts "Between the Sheets"
    begin
      EventScraper.new.scrape_facebook("https://www.facebook.com/pg/betweenthesheets.oldenburg/events/?ref=page_internal", "Between the Sheets")
    rescue => error
      puts error
    end

    puts "Molkerei Klub"
    begin
      EventScraper.new.scrape_facebook("https://www.facebook.com/pg/molkereiklub/events/?ref=page_internal", "Molkerei Klub")
    rescue => error
      puts error
    end

    puts "umBAUbar"
    begin
      EventScraper.new.scrape_facebook("https://www.facebook.com/pg/umBAUbar/events/?ref=page_internal", "umBAUbar")
    rescue => error
      puts error
    end

    puts "Cadillac"
    begin
      EventScraper.new.scrape_facebook("https://www.facebook.com/pg/cadillac.zentrumfurjugendkultur/events/?ref=page_internal", "Cadillac")
    rescue => error
      puts error
    end

    puts "Done!"
  end
end
