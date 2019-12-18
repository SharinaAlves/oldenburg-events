class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  require 'scraping/event_scraper'

  def index
    EventScraper.new.scrape_event_names
    @events = policy_scope(Event)
  end

  def show
    authorize @event
  end
end
