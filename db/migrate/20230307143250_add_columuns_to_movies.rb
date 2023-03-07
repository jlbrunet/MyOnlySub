class AddColumunsToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :plateform_url, :string
  end
end
