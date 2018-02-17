class UsersController < ApplicationController

	def shops
		return redirect_to pagos_path unless current_user.has_subscription?
		
		@shops = current_user.shops
	end

end
