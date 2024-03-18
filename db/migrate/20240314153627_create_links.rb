class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :name, default: '', null: false
      t.string :description, default: '', null: false
      t.string :original_url, null: false
      t.string :short_url, null: false
      t.string :password
      t.date :expires_at

      t.timestamps
    end
  end
end
