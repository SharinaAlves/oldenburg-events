require 'nokogiri'
require 'open-uri'
require 'mechanize'

class EventScraper

  def initialize
    @agent = Mechanize.new
  end

  #def scrape_event_names
  #  url = "https://de.partybeep.com/Startseite/Oldenburg"
#
#    html_file = open(url).read
#    html_doc = Nokogiri::HTML(html_file)
#    page = @agent.get(url)

#    html_doc.search('.ll-ename a').each do |element|
#      if Event.where(name: element.text.strip) == []
        # Event.create(name: element.text.strip, category_id: 2)
        #byebug
#        link = page.link_with(text: element.text.strip)
#        clicked_page = link.click
#        Event.create(
#          category_id: 2,
#          time: clicked_page.at('.ev-time').text.strip,
#          name: clicked_page.search('#ev-name').text.strip)
#      end
#    end
#  end

  def scrape_partys
    all_clubs_url = "https://de.partybeep.com/Clubs/Oldenburg"

    html_file_all_clubs = open(all_clubs_url).read
    html_doc_all_clubs = Nokogiri::HTML(html_file_all_clubs)
    all_clubs_page = @agent.get(all_clubs_url)

    html_doc_all_clubs.search('.lt-name a').each do |element|
      club_link = all_clubs_page.link_with(text: element.text.strip)
      club_url = club_link.click.uri.to_s

      html_file_club = open(club_url).read
      html_doc_club = Nokogiri::HTML(html_file_club)
      club_page = @agent.get(club_url)

      html_doc_club.search('.ld-name a').each do |element|
        event_link = club_page.link_with(text: element.text.strip)
        event_page = event_link.click

        if Event.where(name: element.text.strip) == []
          Event.create(
            category_id: 2,
            name: event_page.at('#ev-name').text.strip,
            date: event_page.at('.ev-day').text.strip,
            time: event_page.at('.ev-time').text.strip,
            location: event_page.at('.address').text.strip,
            description: event_page.at('.description').text.strip,
            image: event_page.at('item-cover img').attr('src')
          )
        end
      end
    end
  end
end
