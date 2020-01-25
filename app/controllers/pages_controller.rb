class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @events = policy_scope(Event)
  end
end
