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
		else
			root_path
		end
	end
end
