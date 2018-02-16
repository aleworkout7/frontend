class UsersController < ApplicationController

	def shops
		@shops = current_user.shops
	end

end
