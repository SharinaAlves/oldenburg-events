class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @events = policy_scope(Event)
  end

  def show
    authorize @event
  end
end
