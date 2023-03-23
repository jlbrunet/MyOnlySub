class AddAvailabilityToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :availability, :integer, default: 30
  end
end
