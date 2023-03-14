class AddColumnsToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :friends, :boolean, default: false
    add_column :contacts, :score, :integer
  end
end
