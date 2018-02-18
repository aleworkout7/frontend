class AddHousingSetRelationsWithPredio < ActiveRecord::Migration
	def change
		add_reference :predios, :housing_set, index: true
	end
end
