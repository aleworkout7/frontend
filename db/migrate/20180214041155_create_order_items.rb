class CreateOrderItems < ActiveRecord::Migration
	def change
		create_table :order_items do |t|
			t.belongs_to :order, index: true, foreign_key: true
			t.belongs_to :product, index: true, foreign_key: true
			t.integer :amount
			t.integer :value

			t.timestamps null: false
		end
	end
end
