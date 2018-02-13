class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.belongs_to :predio, index: true, foreign_key: true
      t.string :number
      t.string :block
      t.integer :floor
      t.string :complement
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
