class AddAvailableToShops < ActiveRecord::Migration
  def change
    add_column :shops, :available, :boolean, default: true
  end
end
