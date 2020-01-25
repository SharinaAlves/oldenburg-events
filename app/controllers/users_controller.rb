class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_current_user, only: [:show, :edit, :update]

  def show
  end

  private

  def set_current_user
    @user = current_user
    authorize @user
  end
end
