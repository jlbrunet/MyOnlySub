class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @movies = Movie.all
  end

  def list
    @bookmarks = Bookmark.where(user:current_user)
  end

  def social
  end

  def sub
  end

  def validation
  end
end
