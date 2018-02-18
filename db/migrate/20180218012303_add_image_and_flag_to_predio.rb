class AddImageAndFlagToPredio < ActiveRecord::Migration
  def change
    add_column :predios, :image, :string
    add_column :predios, :is_highlight, :boolean, default: false
  end
end
