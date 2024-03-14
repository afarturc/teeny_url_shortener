class UpdateForeignKeys < ActiveRecord::Migration[7.1]
  def change
    change_column_null :links, :user_id, false
    change_column_null :clicks, :link_id, false
  end
end
