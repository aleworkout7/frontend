class AddColumnHadSubscriptionBeforeToUser < ActiveRecord::Migration
  def change
    add_column :users, :had_subscription_before, :boolean, default: false
  end
end
