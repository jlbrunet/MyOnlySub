class BookmarksController < ApplicationController
  before_action :look_for_existing_bookmark
  after_action :book_mark_save

  def add
    @bookmark.toggle(:ticked)
    redirect_to root_path
  end

  def seen
    if @bookmark.seen == true
      @bookmark.seen = false
      @bookmark.liked = nill
    else
      @bookmark.seen = true
    end
    redirect_to root_path
  end

  def liked
    if @bookmark.liked.nil? || @bookmark.liked == false
      @bookmark.liked = true
    else
      @bookmark.liked = nil
    end
    redirect_to root_path
  end

  def unliked
    if @bookmark.liked.nil? || @bookmark.liked == true
      @bookmark.liked = false
    else
      @bookmark.liked = nil
    end
    redirect_to root_path
  end

  private

  def look_for_existing_bookmark
    @movie = Movie.find(params[:id])
    if current_user.bookmarks.where(movie_id: params[:id]).count.positive?
      # @bookmark = current_user.bookmarks.where(movie_id: params[:id])
      @bookmark = current_user.bookmarks.where(movie_id: params[:id])[0]
    else
      @bookmark = Bookmark.new
      @bookmark.movie = @movie
      @bookmark.user = current_user
    end
  end

  def book_mark_save
    @bookmark.save
  end
end
