class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_event, only: [:show]
  require 'scraping/event_scraper'

  def index
    #EventScraper.new.scrape_partys
    #EventScraper.new.scrape_facebook
    save_user_location
    @events = policy_scope(Event)
  end

  def show
  end

  private

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end

  def save_user_location
    current_location = cookies[:cl]
    unless current_location.nil?
      @latitude = current_location.split('&')[0].to_f
      @longitude = current_location.split('&')[1].to_f
    end
  end
end
