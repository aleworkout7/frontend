class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.text :greeting
      t.string :number
      t.boolean :whatsapp
      t.boolean :phone
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
