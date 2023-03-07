class ChangeColumnsToMovies < ActiveRecord::Migration[7.0]
  def change
    rename_column :movies, :type, :category
  end
end
