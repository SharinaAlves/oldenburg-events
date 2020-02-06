class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_category, only: [:show]

  def index
    @categories = policy_scope(Category)
  end

  def show
    @events = policy_scope(Event)
  end

  private

  def set_category
    @category = Category.find(params[:id])
    authorize @category
  end
end
