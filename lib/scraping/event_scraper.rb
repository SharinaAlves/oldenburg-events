require 'nokogiri'
require 'open-uri'
require 'mechanize'

class EventScraper

  def initialize
    @agent = Mechanize.new
  end

  def scrape_event_names
    url = "https://de.partybeep.com/Startseite/Oldenburg"

    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)
    page = @agent.get(url)

    html_doc.search('.ll-ename a').each do |element|
      if Event.where(name: element.text.strip) == []
        # Event.create(name: element.text.strip, category_id: 2)
        #byebug
        link = page.link_with(text: element.text.strip)
        clicked_page = link.click
        Event.create(
          category_id: 2,
          time: clicked_page.at('.ev-time').text.strip,
          name: clicked_page.search('#ev-name').text.strip)
      end
    end
  end
end
