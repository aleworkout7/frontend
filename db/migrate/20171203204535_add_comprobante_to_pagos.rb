class AddComprobanteToPagos < ActiveRecord::Migration
  def change
    add_column :pagos, :comprobante, :string
  end
end
