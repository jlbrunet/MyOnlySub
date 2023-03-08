class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  # pour sortable
  acts_as_list column: :priority
  # pour sortable
end
