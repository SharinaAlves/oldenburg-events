class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_category, only: [:show]

  def index
    @categories = policy_scope(Category)
  end

  def show
    if @category.id != "1"
      @events = Event.where(category: @category)
    else
      @events = Event.all
    end

    # @events.sort(:date).each do |event|
    #= render partial: 'events/event_card', locals: { event: event }
    # end

    #if params[:query] != ""
    #  @events = @events.search params[:query]
    #end
    if params[:date_range] != ""
      date_range_array = params[:date_range].split(" to ")
      start_date = Date.parse date_range_array.first
      end_date = Date.parse date_range_array.last
      date_range_array = (start_date..end_date).to_a
      if params[:query] != ""
        @events = @events.search(params[:query], where: { date: date_range_array })
      else
        @events = @events.search(where: { date: date_range_array })
      end
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
    authorize @category
  end
end
