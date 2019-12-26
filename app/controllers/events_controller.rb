class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_event, only: [:show]
  require 'scraping/event_scraper'

  def index
    #EventScraper.new.scrape_partys
    EventScraper.new.scrape_facebook
    @events = policy_scope(Event)
  end

  def show
  end

  private

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end
end
