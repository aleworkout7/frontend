class UsersController < ApplicationController

	def shops
		return redirect_to pagos_path unless current_user.has_subscription?

		@predio = Predio.find(params[:predio_id]) if params[:predio_id].present?
		@shops = current_user.shops
	end

end
