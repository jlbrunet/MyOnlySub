class AddInformationsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :necessary_series, :string, array: true, default: []
    add_column :users, :optional_series, :string, array: true, default: []
    add_column :users, :necessary_movies, :string, array: true, default: []
    add_column :users, :optional_movies, :string, array: true, default: []
  end
end
