class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :phone
      t.string :city
      t.text :comment

      t.timestamps null: false
    end
  end
end
