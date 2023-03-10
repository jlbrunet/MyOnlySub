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
    @user = current_user
    @bookmarks = Bookmark.where(user: current_user).where(ticked: true).order(:priority)
  end

  def sub_variables
    @platforms = {
      netflix: { name: "Netflix", minutes_wishlist: 0, minutes_user: 0, classement: 0, order: 0, order_total: 0 },
      amazon: { name: "Amazon Instant Video", minutes_wishlist: 0, minutes_user: 0, classement: 0, order: 0, order_total: 0 },
      disney: { name: "Disney+", minutes_wishlist: 0, minutes_user: 0, classement: 0, order: 0, order_total: 0 },
      apple: { name: "Apple+", minutes_wishlist: 0, minutes_user: 0, classement: 0, order: 0, order_total: 0 }
    }
    @user_time = current_user.availability * 60 * 1.5
    @duration = 0
  end

  def sub_platform_declaration
    sub_variables

    bookmarks = Bookmark.where(user: current_user).where(ticked: true).order(:priority)
    bookmarks.each do |bookmark|
      platform_name = bookmark.movie.platform
      @platforms.each do |_platform, data|
        if data.value?(platform_name)
          data[:minutes_wishlist] = sub_platform_minutes(bookmark, data[:name], data[:minutes_wishlist])
          if @duration <= @user_time
            last_data_user = data[:minutes_user]
            data[:minutes_user] = sub_platform_minutes(bookmark, data[:name], data[:minutes_user])
            @duration += data[:minutes_user] - last_data_user
          end
        end
      end
    end

    bookmarks.each_with_index do |bookmark, index|
      platform_name = bookmark.movie.platform
      @platforms.each do |_platform, data|
        if data.value?(platform_name)
          data[:order] = sub_platform_indexes(index + 1, data[:order], data[:order_total])[0]
          data[:order_total] = sub_platform_indexes(index + 1, data[:order], data[:order_total])[1]
        end
      end
    end
  end

  def sub_platform_minutes(bookmark, platform_name, platform_minutes)
    if bookmark.movie.platform == platform_name
      case bookmark.movie.category
      when "series"
        platform_minutes += (bookmark.movie.duration.gsub(" min", "").to_i * 20)
      when "movie"
        platform_minutes += bookmark.movie.duration.gsub(" min", "").to_i
      end
    end
    return platform_minutes
  end

  def sub_platform_indexes(index, order, order_total)
    order += index
    order_total += 1
    return [order, order_total]
  end

  def sub
    sub_platform_declaration

    @pair_minutes_extended = {}
    @pair_minutes_wishlist = {}
    @pair_indexed_average = {}
    @pair_final = {}

    @platforms.each do |platform, data|
      @pair_minutes_extended[platform.to_s] = data[:minutes_user]
      @pair_indexed_average[platform.to_s] = data[:order].to_f / data[:order_total]
      if data[:minutes_user] >= @user_time
        data[:classement] = 1
      elsif data[:minutes_user] != 0
        @pair_minutes_wishlist[platform.to_s] = data[:minutes_wishlist]
      else
        data[:classement] = 5
      end
    end

    @pair_minutes_extended.sort.reverse!.each_with_index do |pair, index|
      @platforms[pair[0].to_sym][:classement] += index + 1
    end

    @pair_indexed_average.sort.reverse!.each_with_index do |pair, index|
      @platforms[pair[0].to_sym][:classement] += index + 1
    end

    @pair_minutes_wishlist.sort.each_with_index do |pair, index|
      @platforms[pair[0].to_sym][:classement] += index + 2
    end

    @platforms.each do |platform, data|
      @pair_final[platform.to_s] = data[:classement]
    end

    @final_answer = @pair_final.sort.reverse![0][0]

    @bookmarks = Bookmark.where(user: current_user).where(ticked: true).order(:priority)
    platform_for
  end

  def platform_for
    case @final_answer.to_s
    when "netflix"
      @platform_for_logo = "netflix"
      @platform_for_filter = "Netflix"
    when "amazon"
      @platform_for_logo = "amazon"
      @platform_for_filter = "Amazon Prime Video"
    when "disney"
      @platform_for_logo = "disney"
      @platform_for_filter = "Disney+"
    when "apple"
      @platform_for_logo = "aptv"
      @platform_for_filter = "AppleTV+"
    end
  end

  def social
  end

  def validation
  end
end
