require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'watir'

class EventScraper

  def initialize
    @agent = Mechanize.new
    @browser = Watir::Browser.new
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
            address: event_page.at('.address').text.strip,
            location: event_page.at('.pname').text.strip,
            description: event_page.at('.description').text.strip,
            image: event_page.at('.item-cover img').attr('src')
          )
        end
      end
    end
  end

  def scrape_facebook(club_url)
    @browser.goto(club_url)
    @browser.div(:class, '_4dmk').wait_until_present
    @browser.execute_script("
      const no_upcoming_events_card = document.getElementById('no_upcoming_events_card');
      no_upcoming_events_card.scrollIntoView();
    ")
    html_file_club = @browser.html
    html_doc_club = Nokogiri::HTML(html_file_club)
    club_page = Mechanize::Page.new(nil, {'content-type'=>'text/html'}, html_file_club, nil, @agent)

    html_doc_club.search('._4dmk a').each do |element|
      event_link = club_page.link_with(text: /#{element.text.strip}/)
      event_link_mod = "https://www.facebook.com#{event_link.href}"

      @browser.goto(event_link_mod)
      @browser.div(:class, '_4dpf').wait_until_present
      html_file_event = @browser.html
      html_doc_event = Nokogiri::HTML(html_file_event)

        if Event.where(name: html_doc_event.search('#seo_h1_tag').text.strip)
          .where(date: html_doc_event.search('._2ycp').attr('content').value) == []
          Event.create(
            category_id: 2,
            name: html_doc_event.search('#seo_h1_tag').text.strip,
            date: html_doc_event.search('._2ycp').attr('content').value,
            time: html_doc_event.search('._2ycp').attr('content').value,
            address: html_doc_event.search('._xkh div._5xhp')[1].text.strip,
            location: html_doc_event.search('._b9- a').text.strip,
            description: html_doc_event.search('._63eu').text.strip,
            image: html_doc_event.search('._3ojl img').attr('src').value
          )
        end
    end
  end
end
