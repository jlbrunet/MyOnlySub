class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def recommendation
  end

  def list
    @bookmarks = Bookmark.where(user:current_user)
  end

  def validation
  end

  def social
  end

  def sub
  end
end
