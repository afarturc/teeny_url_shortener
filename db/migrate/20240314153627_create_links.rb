class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :name
      t.string :description
      t.string :custom_alias
      t.string :original_url, null: false
      t.string :short_url, null: false
      t.string :password
      t.date :expired_at

      t.timestamps
    end
  end
end
