class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @movies = Movie.all
    if params[:query].present?
      @movies = Movie.search_by_title_and_synopsis(params[:query])
    end
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "pages/list", locals: {movies: @movies}, formats: [:html] }
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
