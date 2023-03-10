class PagesController < ApplicationController

  def home
    if params[:query].present?
      @results = Movie.search_by_title_and_synopsis(params[:query])
    else
      @results = false
      @movies = Movie.all.order("rating DESC")
      @movies_amazon = @movies.where(platform: "Amazon Prime Video").select { |movie|
        Bookmark.where(user:current_user).where(movie_id: movie.id) == [] }
      @movies_netflix = @movies.where(platform: "Netflix").select { |movie|
        Bookmark.where(user:current_user).where(movie_id: movie.id) == [] }
      @movies_aptv = @movies.where(platform: "AppleTV+").select { |movie|
        Bookmark.where(user:current_user).where(movie_id: movie.id) == [] }
      @movies_disney = @movies.where(platform: "Disney+").select { |movie|
        Bookmark.where(user:current_user).where(movie_id: movie.id) == [] }

      # @movies_amazon = @movies.where(platform: "Amazon Prime Video")
      # @movies_netflix = @movies.where(platform: "Netflix")
      # @movies_aptv = @movies.where(platform: "AppleTV+")
      # @movies_disney = @movies.where(platform: "Disney+")

    end
    respond_to do |format|
      format.text { render partial: "pages/list", locals: {movies: @results}, formats: [:html] }
      format.html # Follow regular flow of Rails
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
