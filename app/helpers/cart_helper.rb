module CartHelper

	def calculate_total_cart cart
		 return 0 if cart.blank?

		 total = 0

		 cart.each { |c| total += (c[:product].price * c[:amount].to_i) }

		 number_to_currency total, unit: "", separator: ",", delimiter: "."
	end
end
