class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    if params[:query].present?
      @results = Movie.search_by_title_and_synopsis(params[:query])
    else
      @movies = Movie.all.order("rating DESC")
      @movies_netflix = @movies.where(platform: "Netflix").first(50)
      @movies_amazon = @movies.where(platform: "Amazon Prime Video").first(50)
      @movies_aptv = @movies.where(platform: "AppleTV+").first(50)
      @movies_disney = @movies.where(platform: "Disney+").first(50)
      # @bookmark = Bookmark.new    // qui à volé l'orange du marchand ??
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
