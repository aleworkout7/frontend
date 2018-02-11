class AddPredioIdToShops < ActiveRecord::Migration
  def change
    add_column :shops, :predio_id, :integer
  end
end
