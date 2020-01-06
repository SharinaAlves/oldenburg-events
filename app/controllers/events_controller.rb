class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_event, only: [:show]
  require 'scraping/event_scraper'

  def index
    save_user_location
    @events = policy_scope(Event)
    #@events.each { |event| get_distance(event) }
  end

  def show
  end

  def scrape
    ScrapeJob.set(wait_until: Date.tomorrow.noon).perform_later
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

  def get_distance(event)
    url = "https://maps.googleapis.com/maps/api/directions/json?
        origin=#{@latitude},#{@longitude}
        &destination=#{event.latitude},#{event.longitude}
        &key=#{ENV['GOOGLE_API_SERVER_KEY']}"
    http_call = open(url).read
    response = JSON.parse(http_call, {symbolize_name: true})
    #@distance = response[:routes][:distance][:text]
  end
end
