require 'nokogiri'
require 'open-uri'
# require 'mechanize'

class EventScraper
  def scrape_event_names
    url = "https://de.partybeep.com/Startseite/Oldenburg"

    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.ll-ename a').each do |element|
      if Event.where(name: element.text.strip) == []
        byebug
        Event.create(name: element.text.strip, category_id: 2)
      end
    end
  end
end
