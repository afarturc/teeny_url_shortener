class AddForeignKeys < ActiveRecord::Migration[7.1]
  def change
    add_column :links, :user_id, :integer, null: false
    add_column :clicks, :link_id, :integer, null: false
    add_foreign_key :links, :users
    add_foreign_key :clicks, :links
  end
end
