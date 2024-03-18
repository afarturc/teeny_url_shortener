class CreateClicks < ActiveRecord::Migration[7.1]
  def change
    create_table :clicks do |t|
      t.string :device_ip, null: false
      t.string :system, null: false
      t.string :browser, null: false
      t.string :language, null: false
      t.string :platform, null: false
      t.timestamps
    end
  end
end
