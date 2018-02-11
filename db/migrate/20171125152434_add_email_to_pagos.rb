class AddEmailToPagos < ActiveRecord::Migration
  def change
    add_column :pagos, :email, :string
  end
end
