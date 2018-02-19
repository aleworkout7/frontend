class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:account_update,
			keys: [
				:name, :email, :phone, :password, :password_confirmation, :current_password,
				addresses: [ :predio_id, :number, :block, :floor, :complement ]
			]
		)
	end

	protected

	def after_sign_in_path_for(resource)
		if params[:do_subscription].present?
			pagos_path
		elsif params[:go_back_to_cart].present?
			product = Product.find(params[:go_back_to_cart])
			add_to_cart_predio_shop_path(product.shop.predio.id, product.shop.id, product.id)
		else
			root_path
		end
	end

	def after_sign_out_path_for(resource)
		new_user_session_path
	end

	def check_if_user_is_logged_in
		return redirect_to new_user_registration_path unless user_signed_in?
		return redirect_to root_path unless current_user.admin?
	end
end
