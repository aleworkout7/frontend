class RemoveFieldNameFromPago < ActiveRecord::Migration
  def change
    remove_column :pagos, :pago_id, :integer
  end
end
