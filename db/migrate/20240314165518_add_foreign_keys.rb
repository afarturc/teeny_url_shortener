class AddForeignKeys < ActiveRecord::Migration[7.1]
  def change
    add_column :links, :user_id, :integer
    add_column :clicks, :link_id, :integer
    add_foreign_key :links, :users
    add_foreign_key :clicks, :links
  end
end
