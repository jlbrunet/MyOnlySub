class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    if params[:query].present?
      @results = Movie.search_by_title_and_synopsis(params[:query])
    else
      @movies = Movie.all
      @bookmark = Bookmark.new
    end
  end

  def list
    @bookmarks = Bookmark.where(user:current_user).where(ticked: true).order(:priority)
  end

  def social
  end

  def sub
  end

  def validation
  end
end
