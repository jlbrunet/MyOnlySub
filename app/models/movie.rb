class Movie < ApplicationRecord
  has_many :bookmarks, dependent: :destroy

  include PgSearch::Model
  pg_search_scope :search_by_title_and_synopsis, against: [
                  [:title, 'A'],
                  [:synopsis, 'B'],
                  [:genre, 'C'],
                  [:actors, 'D'],
                  ],
                  using: {
                  tsearch: { prefix: true } # <-- now `superman batm` will return something!
                  }
end
