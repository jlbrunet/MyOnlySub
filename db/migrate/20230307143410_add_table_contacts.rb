class AddTableContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.references :first_user, null: false, foreign_key: { to_table: :users}
      t.references :second_user, null: false, foreign_key: { to_table: :users}
      t.timestamps
    end
  end
end
