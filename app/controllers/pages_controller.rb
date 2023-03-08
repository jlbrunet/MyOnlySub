class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    if params[:query].present?
      sql_query = "title ILIKE :query OR synopsis ILIKE :query OR category ILIKE :query OR genre ILIKE :query OR actors ILIKE :query"
      @results = Movie.where(sql_query, query: "%#{params[:query]}%")
    else
      @movies = Movie.all
    end
  end

  def list
    @bookmarks = Bookmark.where(user:current_user).order(:priority)
  end

  def social
  end

  def sub
  end

  def validation
  end
end
