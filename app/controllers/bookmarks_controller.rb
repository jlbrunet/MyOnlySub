class BookmarksController < ApplicationController
  before_action :look_for_existing_bookmark

# Démarche commune au trois :

    # récuperer l'IMBDid
    # voir si il existe un bookmark associé à ce IMDB id
    # si pas de bookmark, en créer un avec IMDB id / current_user et ticked = true
    # si un bookmark, ticked 'false' => 'true' || ticked 'true' => 'false' (sorte de toggle)

  def add
    @bookmark.toggle(:ticked).save
  end

  def seen
    if @bookmark.seen = true
      @bookmark.seen = false
      @bookmark.liked = nill
      @bookmark.save
    else
      @bookmark.seen = true
    end
  end

  def liked
    if @bookmark.liked = nil

  end

  private

  def look_for_existing_bookmark
    @movie = Movie.find(params[:movie_id])
    if Bookmark.where(movie_id: params[:movie_id]).positive?
      @bookmark = Bookmark.where(movie_id: params[:movie_id])
    else
      @bookmark = Bookmark.new
      @bookmark.movie = @movie
      @bookmark.user = current_user
      @bookmark.save
    end
  end


end
