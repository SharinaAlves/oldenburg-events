class EventsController < ApplicationController
  def index
  end

  def show
    authorize @event
  end
end
