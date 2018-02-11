class RemoveFieldNameFromProduct < ActiveRecord::Migration
  def change
    remove_column :products, :shop_id, :integer
  end
end
