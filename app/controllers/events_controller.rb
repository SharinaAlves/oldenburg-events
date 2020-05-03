class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_event, only: [:show]
  require 'scraping/event_scraper'

  def index
    save_user_location
    Event.reindex
    @events = policy_scope(Event)
    #@events = Event.search(params[:query]) if params[:query]
    #@events.each { |event| get_distance(event) if event.latitude != nil }
    set_bookmarks
  end

  def show
    set_bookmarks
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
    url = "https://maps.googleapis.com/maps/api/directions/json?origin=#{@latitude},#{@longitude}&destination=#{event.latitude},#{event.longitude}&key=#{ENV['GOOGLE_API_KEY_DIRECTIONS']}"
    http_call = open(url).read
    response = JSON.parse(http_call, {symbolize_name: true})
    @distance = response["routes"][0]["legs"][0]["distance"]["text"]
  end

  def set_bookmarks
    @bookmarks = policy_scope(Bookmark)
    @bookmarks = @bookmarks.where(user: current_user)
    #authorize @bookmark
  end
end
