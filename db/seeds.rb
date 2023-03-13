User.all.each do |user|
  user.photo.purge
end

User.destroy_all

user1 = User.new(
  first_name: "Julie",
  last_name: "Brunet",
  age: 26,
  email: "julieb@lewagon.org",
  password: "123456"
)
user1.photo.attach(
  io: File.open('public/images/julie.jpg'),
  filename: 'anyname.jpg', # use the extension of the attached file here
  content_type: 'image/jpg' # use the mime type of the attached file here
)
user1.save!

user2 = User.new(
  first_name: "Maxime",
  last_name: "Coquerelle",
  age: 31,
  email: "maximec@lewagon.org",
  password: "123456"
)
user2.photo.attach(
  io: File.open('public/images/max.jpg'),
  filename: 'anyname.jpg', # use the extension of the attached file here
  content_type: 'image/jpg' # use the mime type of the attached file here
)
user2.save!

user3 = User.new(
  first_name: "Amélie",
  last_name: "Berthier",
  age: 24,
  email: "amélieb@lewagon.org",
  password: "123456"
)
user3.photo.attach(
  io: File.open('public/images/amelie.jpg'),
  filename: 'anyname.jpg', # use the extension of the attached file here
  content_type: 'image/jpg' # use the mime type of the attached file here
)
user3.save!

user4 = User.new(
  first_name: "Bastien",
  last_name: "Lafont",
  age: 29,
  email: "bastienl@lewagon.org",
  password: "123456"
)
user4.photo.attach(
  io: File.open('public/images/bastien.jpg'),
  filename: 'anyname.jpg', # use the extension of the attached file here
  content_type: 'image/jpg' # use the mime type of the attached file here
)
user4.save!

require "json"

Movie.destroy_all

filepath = "db/data/movies.json"

serialized_movies = File.read(filepath)

hashmovies = JSON.parse(serialized_movies)

hashmovies["movies"].each do |movie|
  Movie.create(movie)
end


# a enlever quand on ajoutera plus de film
Movie.where(platform: "Amazon Instant Video").first(50).each do |movie|
  movie.platform = "Amazon Prime Video"
  movie.save
end

# a enlever quand on ajoutera plus de film
Movie.where(platform: "Amazon Instant Video").each do |movie|
  movie.platform = "Disney+"
  movie.save
end

# a enlever quand on ajoutera plus de film
Movie.where(platform: "iTunes").each do |movie|
  movie.platform = "AppleTV+"
  movie.save
end

Movie.where(category: "movie").each do |movie|
  if movie.duration.gsub(" min", "").to_i < 60
    movie.duration = "120 min"
    movie.save
  end
end

Movie.where(category: "series").each do |serie|
  if serie.duration.gsub(" min", "").to_i < 20
    serie.duration = "40 min"
    serie.save
  end
end
