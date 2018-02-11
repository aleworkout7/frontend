class RemoveFieldNameAgainFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :shop_name, :string
  end
end
