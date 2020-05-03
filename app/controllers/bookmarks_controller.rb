class BookmarksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :create, :delete]
  before_action :set_current_user, only: [:indes, :delete]

  def index
    @bookmarks = policy_scope(Bookmark)
    @bookmarks = @bookmarks.where(user: current_user)
  end

  def create
    @bookmark = Bookmark.new(user: current_user, event_id: params[:format].to_i)
    @bookmark.save
    authorize @bookmark
    redirect_to @bookmark.event
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    authorize @bookmark
    redirect_to @bookmark.event
  end

  private

  def set_current_user
    @user = current_user
    authorize @user
  end

  def bookmark_params
    params.require(:bookmark).permit(:user, :event)
  end
end
