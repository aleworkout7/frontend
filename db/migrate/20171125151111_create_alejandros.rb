class CreateAlejandros < ActiveRecord::Migration
  def change
    create_table :alejandros do |t|
      t.string :email
      t.integer :payment
      t.date :payment_date
      t.date :due_date
      t.text :message
      t.integer :id_member

      t.timestamps null: false
    end
  end
end
