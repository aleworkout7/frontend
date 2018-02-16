class CreatePaymentNotifications < ActiveRecord::Migration
  def change
    create_table :payment_notifications do |t|
      t.string :transaction_id
      t.integer :payer_id, :limit => 8
      t.string :status
      t.string :external_reference
      t.float :total_paid_amount
      t.string :payment_type
      t.string :payment_method_id
      t.integer :transaction_order_id, :limit => 8
      t.datetime :date_created
      t.datetime :date_approved
      t.datetime :money_release_date
      t.datetime :last_modified

      t.timestamps null: false
    end
  end
end
