class Users::RegistrationsController < Devise::RegistrationsController
	# before_action :configure_sign_up_params, only: [:create]
	# before_action :configure_account_update_params, only: [:update]

	# GET /resource/sign_up
	# def new
	#   super
	# end

	# POST /resource
	# def create
	#   super
	# end

	# GET /resource/edit
	def edit
		if current_user.address.blank?
			current_user.addresses << Address.new
			return redirect_to edit_user_registration_path
		end

		super

		if params[:cart].present?
			@predio = Shop.find(params[:cart]).predio
			session[:predio_id] = @predio.id
			session[:predio_name] = @predio.name
		end
	end

	# PUT /resource
	def update
		super

		user = User.where(email: params[:user][:email]).first
		if user.present?
			if params[:addresses][:id].present?
				id = params[:addresses].delete(:id)
				address = Address.find(id)
				address.update_attributes(params[:addresses].permit!)
			else
				address = Address.new(params[:addresses].permit!)
			end

			user.addresses << address
		end
	end

	# DELETE /resource
	# def destroy
	#   super
	# end

	# GET /resource/cancel
	# Forces the session data which is usually expired after sign
	# in to be expired now. This is useful if the user wants to
	# cancel oauth signing in/up in the middle of the process,
	# removing all OAuth session data.
	# def cancel
	#   super
	# end

	# protected

	# If you have extra params to permit, append them to the sanitizer.
	# def configure_sign_up_params
	#   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
	# end

	# If you have extra params to permit, append them to the sanitizer.
	# def configure_account_update_params
	#   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
	# end

	# The path used after sign up.
	# def after_sign_up_path_for(resource)
	#   super(resource)
	# end

	def after_update_path_for(resource)
		if params[:cart].present?
			flash[:notice] = "Agora só precisa confirmar seu pedido"

			shop = Shop.find(params[:cart])
			cart_predio_shop_path(shop.predio, shop)
		else
			root_path
		end
	end

	# The path used after sign up for inactive accounts.
	# def after_inactive_sign_up_path_for(resource)
	#   super(resource)
	# end

	protected

	def update_resource(resource, uparams)
		if params[:cart].present?
			resource.update_without_password(uparams)
		elsif params[:update_password].present?
			resource.update_with_password(uparams)
		else
			resource.update(uparams)
		end
	end
end
