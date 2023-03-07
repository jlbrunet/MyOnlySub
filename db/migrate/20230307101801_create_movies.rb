class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :imbdid
      t.string :title
      t.string :synopsis
      t.string :picture_url
      t.integer :year
      t.string :duration
      t.float :rating
      t.string :type
      t.string :genre
      t.integer :seasons, default: 0
      t.string :actors
      t.string :director
      t.string :platform

      t.timestamps
    end
  end
end
