class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    if params[:query].present?
      @results = Movie.search_by_title_and_synopsis(params[:query])
    else
      @movies = Movie.all
      # @bookmark = Bookmark.new
    end
  end

  def list
    @user = current_user
    @bookmarks = Bookmark.where(user: current_user).where(ticked: true).order(:priority)
  end

  def sub
    sub_platform_declaration

    pair_minutes_extended = {}
    pair_indexed_average = {}
    pair_minutes_wishlist = {}
    pair_final = {}

    platforms.each do |platform|
      pair_minutes_extended.platform.name = platform.minutes_extended
      pair_indexed_average.platform.name = platform.order / platform.order_total
      if platform.minutes_extended >= user_time_extended
        platform.classement = 1
      else
        pair_minutes_wishlist.platform.name = platform.minutes_wishlist
      end
    end

    platforms.each_with_index { |(platform, value), index|
      platform.pair_minutes_extended.sort.keys[index].classement = index + 1
      platform.pair_indexes_average.sort.keys[index].classement = index + 1
      platform.pair_minutes_wishlist.sort.keys[index].classement = index + 2
    }

    platforms.each do |platform|
      pair_final.platform.name = platform.classement
    end

    platforms.each_with_index { |(platform, value), index|
      @final_answer = platform.pair_final.sort.keys[0]
    }
  end

  def sub_platform_declaration
    sub_variables_declaration

    bookmarks = Bookmark.where(user: current_user).where(ticked: true)

    bookmarks.each do |bookmark|
      @platforms.each do |_platform, data|
        data[:minutes_wishlist] = sub_platform_minutes(bookmark, data[:name], data[:minutes_wishlist])
        while @duration <= @user_time
          data[:minutes_user] = sub_platform_minutes(bookmark, data[:name], data[:minutes_user])
          @duration += data[:minutes_user]
        end
      end
    end

    bookmarks.each_with_index do |bookmark, index|
      platform_name = bookmark.movie.platform
      raise
      sub_platform_minutes(bookmark, index, platforms.platform_name.order, platforms.platform_name.order_total)
    end
  end

  def sub_variables_declaration
    @platforms = {
      netflix: { name: "Netflix", minutes_wishlist: 0, minutes_user: 0, classement: 0, order: 0, order_total: 0 },
      amazon: { name: "Amazon Prime Video", minutes_wishlist: 0, minutes_user: 0, classement: 0, order: 0, order_total: 0 },
      disney: { name: "Disney+", minutes_wishlist: 0, minutes_user: 0, classement: 0, order: 0, order_total: 0 },
      apple: { name: "Apple+", minutes_wishlist: 0, minutes_user: 0, classement: 0, order: 0, order_total: 0 }
    }
    @user_time = current_user.availability * 60 * 1.5
    @duration = 0
  end

  def sub_platform_minutes(bookmark, platform_name, platform_minutes)
    if bookmark.movie.platform == platform_name
      case bookmark.movie.category
      when "series"
        platform_minutes += bookmark.movie.duration.gsub(" min", "").to_i * 20
      when "movie"
        platform_minutes += bookmark.movie.duration.gsub(" min", "").to_i
      end
    end
    return platform_minutes
  end

  def sub_platform_indexes(bookmark, index, order, order_total)
    if bookmark.movie.platform == platform_name
      order += index
      order_total += 1
    end
  end

  def social
  end

  def validation
  end
end
