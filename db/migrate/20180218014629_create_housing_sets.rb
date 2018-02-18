class CreateHousingSets < ActiveRecord::Migration
  def change
    create_table :housing_sets do |t|
      t.string :name
      t.belongs_to :district, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
