class CreatePredios < ActiveRecord::Migration
  def change
    create_table :predios do |t|
      t.string :name
      t.text :address
      t.text :details

      t.timestamps null: false
    end
  end
end
