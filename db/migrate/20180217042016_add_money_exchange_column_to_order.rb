class AddMoneyExchangeColumnToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :money_exchange, :integer, default: 0
  end
end
