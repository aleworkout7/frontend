class AddColumnToPagos < ActiveRecord::Migration
  def change
    add_column :pagos, :banco_id, :integer
    add_column :pagos, :pago_id, :integer
    add_column :pagos, :account_number, :string
  end
end
