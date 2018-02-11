class CreatePagos < ActiveRecord::Migration
  def change
    create_table :pagos do |t|
      t.integer :user_id
      t.integer :member_id
      t.date :payment_date
      t.integer :amount
      t.text :message
      t.boolean :checked
      t.string :predio_name
      t.text :predio_address

      t.timestamps null: false
    end
  end
end
