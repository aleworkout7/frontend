class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.string :greeting
      t.string :img
      t.string :img_seller

      t.timestamps null: false
    end
  end
end
