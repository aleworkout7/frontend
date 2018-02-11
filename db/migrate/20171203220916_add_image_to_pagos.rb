class AddImageToPagos < ActiveRecord::Migration
  def change
    add_column :pagos, :image, :string
  end
end
