class EventsController < ApplicationController
  def index
    @events = policy_scope(Event)
  end

  def show
    #authorize @event
  end
end
