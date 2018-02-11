class RemoveComprobanteFromPago < ActiveRecord::Migration
  def change
    remove_column :pagos, :comprobante, :string
  end
end
