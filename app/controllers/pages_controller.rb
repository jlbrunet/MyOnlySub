class PagesController < ApplicationController
  def home
    if params[:query].present?
      @results = Movie.search_by_title_and_synopsis(params[:query])
    else
      @results = false
      @movies = Movie.all.order("rating DESC")
      @movies_amazon = @movies.where(platform: "Amazon Prime Video").select { |movie| condition(movie) }
      @movies_netflix = @movies.where(platform: "Netflix").select { |movie| condition(movie) }
      @movies_aptv = @movies.where(platform: "AppleTV+").select { |movie| condition(movie) }
      @movies_disney = @movies.where(platform: "Disney+").select { |movie| condition(movie) }

      @movies_comedy = @movies.where("genre ILIKE ?", "%comedy%").select { |movie| condition(movie) }.shuffle
      @movies_action = @movies.where("genre ILIKE ?", "%action%").select { |movie| condition(movie) }.shuffle
      @movies_adventure = @movies.where("genre ILIKE ?", "%adventure%").select { |movie| condition(movie) }.shuffle
      @movies_horror = @movies.where("genre ILIKE ?", "%horror%").select { |movie| condition(movie) }.shuffle
      @movies_fantasy = @movies.where("genre ILIKE ?", "%fantasy%").select { |movie| condition(movie) }.shuffle
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

  def favorites
    @user = current_user
    @bookmarks = Bookmark.where(user: current_user).where(liked: true)
  end

  def sub_variables
    @platforms = {
      netflix: { name: "Netflix", minutes_wishlist: 0, minutes_user: 0, classement: 0, order: 1, order_total: 1 },
      amazon: { name: "Amazon Prime Video", minutes_wishlist: 0, minutes_user: 0, classement: 0, order: 1, order_total: 1 },
      disney: { name: "Disney+", minutes_wishlist: 0, minutes_user: 0, classement: 0, order: 1, order_total: 1 },
      apple: { name: "AppleTV+", minutes_wishlist: 0, minutes_user: 0, classement: 0, order: 1, order_total: 1 }
    }
    @user_time = current_user.availability * 60 * 1.5
    @duration = 0
    @movies_necessary = []
    @movies_total = []
    @movies_optional = []
  end

  def sub_platform_declaration
    sub_variables

    bookmarks = Bookmark.where(user: current_user).where(ticked: true).order(:priority)
    bookmarks.each do |bookmark|
      platform_name = bookmark.movie.platform
      @platforms.each do |_platform, data|
        if data.value?(platform_name)
          data[:minutes_wishlist] = sub_platform_minutes(bookmark, data[:name], data[:minutes_wishlist])
          @movies_total.push(Movie.find(bookmark.movie_id))
          if @duration <= @user_time
            last_data_user = data[:minutes_user]
            data[:minutes_user] = sub_platform_minutes(bookmark, data[:name], data[:minutes_user])
            @movies_necessary.push(Movie.find(bookmark.movie_id))
            @duration += data[:minutes_user] - last_data_user
          end
        end
      end
    end

    @movies_total.each do |movie|
      unless @movies_necessary.include?(movie)
        @movies_optional.push(movie)
      end
    end

    @movies_optional_series = []
    @movies_necessary_series = []
    @movies_optional_movies = []
    @movies_necessary_movies = []
    @movies_optional_series_id = []
    @movies_necessary_series_id = []
    @movies_optional_movies_id = []
    @movies_necessary_movies_id = []

    @movies_optional.each do |movie|
      if movie.category == "series"
        @movies_optional_series.push(movie)
        @movies_optional_series_id.push(movie.id)
      end
    end

    @movies_optional.each do |movie|
      if movie.category == "movie"
        @movies_optional_movies.push(movie)
        @movies_optional_movies_id.push(movie.id)
      end
    end

    @movies_necessary.each do |movie|
      if movie.category == "movie"
        @movies_necessary_movies.push(movie)
        @movies_necessary_movies_id.push(movie.id)
      end
    end

    @movies_necessary.each do |movie|
      if movie.category == "series"
        @movies_necessary_series.push(movie)
        @movies_necessary_series_id.push(movie.id)
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

      @pair_minutes_extended.sort_by {|key, value| value}.reverse!.each_with_index do |pair, index|
        @platforms[pair[0].to_sym][:classement] += index + 1
      end

      @pair_indexed_average.sort_by {|key, value| value}.reverse!.each_with_index do |pair, index|
        @platforms[pair[0].to_sym][:classement] += index + 1
      end

      @pair_minutes_wishlist.sort_by {|key, value| value}.each_with_index do |pair, index|
        @platforms[pair[0].to_sym][:classement] += index + 2
      end

      @platforms.each do |platform, data|
        @pair_final[platform.to_s] = data[:classement]
      end

      @final_answer = @pair_final.sort_by {|key, value| value}[0][0]

      if params[:trick]
        @movies_necessary_movies = []
        @movies_necessary_series = []
        @movies_optional_movies = []
        @movies_optional_series = []
        @movies_necessary = []
        @movies_optional = []

        @final_answer = current_user.suggested_platform
        current_user.necessary_movies.each do |movie|
          @movies_necessary_movies.push(Movie.find(movie))
        end
        current_user.necessary_series.each do |movie|
          @movies_necessary_series.push(Movie.find(movie))
        end
        current_user.optional_movies.each do |movie|
          @movies_optional_movies.push(Movie.find(movie))
        end
        current_user.optional_series.each do |movie|
          @movies_optional_series.push(Movie.find(movie))
        end

        @movies_necessary = @movies_necessary_movies + @movies_necessary_series
        @movies_optional = @movies_optional_movies + @movies_optional_series

        @bookmarks = Bookmark.where(user: current_user).where(ticked: true).order(:priority)
        platform_for
      else
        current_user.suggested_platform = @final_answer
        current_user.necessary_movies = @movies_necessary_movies_id
        current_user.necessary_series = @movies_necessary_series_id
        current_user.optional_movies = @movies_optional_movies_id
        current_user.optional_series = @movies_optional_series_id
        current_user.save

        @bookmarks = Bookmark.where(user: current_user).where(ticked: true).order(:priority)
        platform_for
      end
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

  def condition(movie)
    Bookmark.where(user: current_user).where(movie_id: movie.id) == [] || Bookmark.where(user: current_user).where(movie_id: movie.id).first[:ticked] == false
  end

  def social
    @users = User.all
    @bookmarks_cu = Bookmark.where(user: current_user)
    @users.each do |user|
      if Contact.where(first_user_id: user.id).where(second_user_id: current_user.id) == []
        if Contact.where(first_user_id: current_user.id).where(second_user_id: user.id) == []
          @contact = Contact.new(first_user_id: current_user.id, second_user_id: user.id, score: 0)
        else
          @contact = Contact.where(first_user_id: current_user.id).where(second_user_id: user.id).first
        end
      else
        @contact = Contact.where(first_user_id: user.id).where(second_user_id: current_user.id).first
      end
      # utiliser @contact et le save à la fin
      bookmarks_u = Bookmark.where(user_id: user.id)
      sum = 0
      bookmarks_u.each do |bookmark|
        if @bookmarks_cu.where(movie_id: bookmark[:movie_id] ) != []
          bookmark_cu = @bookmarks_cu.where(movie_id: bookmark[:movie_id]).first
          if bookmark_cu[:liked] == bookmark[:liked] && (bookmark_cu[:liked] == true || bookmark_cu[:liked] == false)
            sum += 5
          elsif bookmark_cu[:liked] != bookmark[:liked] && bookmark_cu[:liked] != nil && bookmark_cu[:liked] != nil
            sum -= 3
          end
        end
      end

      @contact.score = sum
      @contact.save
    end
    @contact_double = Contact.where(first_user_id: current_user.id).where(second_user_id: current_user.id).first
    @contact_double.score = -400
    @contact_double.save

    my_users = {}
    (Contact.where(first_user_id: current_user.id) + Contact.where(second_user_id: current_user.id)).each do |x|
      my_users[x.id.to_s] = x.score
    end
    @results = my_users.sort { |a, b| a[1] <=> b[1] }.reverse.first(3)
  end

  def validation
  end
end
