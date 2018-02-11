class AddFieldNameToProduct < ActiveRecord::Migration
  def change
    add_column :products, :shop_name, :string
  end
end
