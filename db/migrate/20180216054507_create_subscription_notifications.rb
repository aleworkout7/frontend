class CreateSubscriptionNotifications < ActiveRecord::Migration
  def change
    create_table :subscription_notifications do |t|
      t.string :transaction_id
      t.integer :payer_id, :limit => 8
      t.integer :collector_id, :limit => 8
      t.integer :application_id, :limit => 8
      t.string :status
      t.string :external_reference
      t.datetime :date_created
      t.datetime :last_modified

      t.timestamps null: false
    end
  end
end
