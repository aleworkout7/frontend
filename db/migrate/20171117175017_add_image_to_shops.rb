class AddImageToShops < ActiveRecord::Migration
  def change
    add_column :shops, :image, :string
  end
end
