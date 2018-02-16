class CreateSubscriptionNotifications < ActiveRecord::Migration
  def change
    create_table :subscription_notifications do |t|
      t.string :transaction_id
      t.integer :payer_id
      t.integer :collector_id
      t.integer :application_id
      t.string :status
      t.string :external_reference
      t.datetime :date_created
      t.datetime :last_modified

      t.timestamps null: false
    end
  end
end
