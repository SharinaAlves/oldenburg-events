require 'nokogiri'
require 'open-uri'
# require 'mechanize'

class EventScraper
  url = "https://de.partybeep.com/Startseite/Oldenburg"

  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)

  html_doc.search('.ll-ename').each do |element|
    event = Event.new
    event.name = element.text.strip
    event.save
  end
end
