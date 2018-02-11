class AddAccountIdToPagos < ActiveRecord::Migration
  def change
    add_column :pagos, :account_id, :integer
  end
end
