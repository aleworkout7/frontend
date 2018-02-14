class CreateOrderStatuses < ActiveRecord::Migration
  def change
    create_table :order_statuses do |t|
      t.belongs_to :order, index: true, foreign_key: true
	  t.belongs_to :user, index: true, foreign_key: true
      t.text :observation
      t.string :status

      t.timestamps null: false
    end
  end
end
