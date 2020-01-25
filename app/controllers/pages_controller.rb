class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :map]

  def home
    @events = policy_scope(Event)
  end

  def map
    @events = policy_scope(Event)
    @events = Event.where(date: Date.today).geocoded

    @markers = @events.map do |event|
      {
        lat: event.latitude,
        lng: event.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { event: event })
      }
    end
  end
end
