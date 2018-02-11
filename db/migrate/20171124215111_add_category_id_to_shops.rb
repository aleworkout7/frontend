class AddCategoryIdToShops < ActiveRecord::Migration
  def change
    add_column :shops, :category_id, :integer
  end
end
