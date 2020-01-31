require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'watir'
require "chromedriver-helper"

class EventScraper
  def initialize
    @agent = Mechanize.new
    Selenium::WebDriver::Chrome.path = "/app/.apt/usr/bin/google-chrome"
    Selenium::WebDriver::Chrome.driver_path = "/app/.chromedriver/bin/chromedriver"
    @browser = Watir::Browser.new :chrome #, headless: true
    #@browser = new_browser
    # Kill browser!
    # Drop db
  end

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
            category_id: 17,
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
      @browser.close
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
      @browser.div(:class, '_63ew').wait_until_present
      html_file_event = @browser.html
      html_doc_event = Nokogiri::HTML(html_file_event)

        if Event.where(name: html_doc_event.search('#seo_h1_tag').text.strip)
          .where(date: html_doc_event.search('._2ycp').attr('content').value) == []
          Event.create(
            category_id: 17,
            name: html_doc_event.search('#seo_h1_tag').text.strip,
            date: html_doc_event.search('._2ycp').attr('content').value,
            time: html_doc_event.search('._2ycp').attr('content').value,
            address: html_doc_event.search('._xkh div._5xhp')[1].text.strip,
            location: html_doc_event.search('._b9- a').text.strip,
            description: html_doc_event.search('._63eu').text.strip,
            image: html_doc_event.search('._3ojl img').attr('src').value
            #ticket: html_doc_event.search('._2ib4 a').attr('href').value
          )
        end
    end
  end

   private

  def new_browser(downloads: false)
    options = Selenium::WebDriver::Chrome::Options.new

    # make a directory for chrome if it doesn't already exist
    chrome_dir = File.join Dir.pwd, %w(tmp chrome)
    FileUtils.mkdir_p chrome_dir
    user_data_dir = "--user-data-dir=#{chrome_dir}"
    # add the option for user-data-dir
    options.add_argument user_data_dir

    # let Selenium know where to look for chrome if we have a hint from
    # heroku. chromedriver-helper & chrome seem to work out of the box on osx,
    # but not on heroku.
    if chrome_bin = ENV["GOOGLE_CHROME_SHIM"]
      options.add_argument "--no-sandbox"
      options.binary = chrome_bin
    end

    # headless!
    options.add_argument "--window-size=1200x600"
    options.add_argument "--headless"
    options.add_argument "--disable-gpu"

    # make the browser
    browser = Watir::Browser.new :chrome, options: options

    # setup downloading options
    if downloads
      # make download storage directory
      downloads_dir = File.join Dir.pwd, %w(tmp downloads)
      FileUtils.mkdir_p downloads_dir

      # tell the bridge to use downloads
      bridge = browser.driver.send :bridge
      path = "/session/#{bridge.session_id}/chromium/send_command"
      params = { behavior: "allow", downloadPath: downloads_dir }
      bridge.http.call(:post, path, cmd: "Page.setDownloadBehavior",
                                    params: params)
    end
    browser
  end
end
