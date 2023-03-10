class Movie < ApplicationRecord
  has_many :bookmarks, dependent: :destroy

  include PgSearch::Model
  pg_search_scope :search_by_title_and_synopsis, against: [
                  [:title, 'A'],
                  [:actors, 'B'],
                  [:director, 'C'],
                  [:genre, 'D'],
                  ],
                  using: {
                  tsearch: { prefix: true }
                  }
end
