class SetDefaults < ActiveRecord::Migration[7.1]
  def change
    change_column_null :links, :name, false
    change_column_null :links, :description, false
    change_column_default :links, :name, ''
    change_column_default :links, :description, ''
  end
end
