class ShopsController < ApplicationController
	before_action :set_shop, only: [:show, :edit, :update, :destroy]
	before_action :is_published?, only: [:show]
	before_action :require_permission, only: :edit
	before_action :require_permission_destroy, only: :destroy

	# GET /shops
	# GET /shops.json
	def index
		redirect_to root_path
	end

	# GET /predio/:id/shops
	def predio
		@predio = Predio.find(params[:id])
		@shops = Shop.search({ predio_id: @predio.id, search: params[:search] }).published
	end

	# GET /shops/1
	# GET /shops/1.json
	def show
		params[:q] = "" if params[:q].blank?
		@shop = Shop.find(params[:id])
		@products = @shop.products.where("lower(name) like :name", { name: "%#{params[:q].downcase}%" })
	end

	# GET /shops/new
	def new
		@shop = Shop.new
		@predios = Predio.all
	end

	# GET /shops/1/edit
	def edit
		@categories = Category.all
		@predios = Predio.all
	end

	# POST /shops
	# POST /shops.json
	def create
		@shop = Shop.new(shop_params)
		@shop.user_id = current_user.id if current_user
		respond_to do |format|
			if @shop.save
				format.html { redirect_to @shop, notice: 'Tienda creada exitosamente.' }
				format.json { render :show, status: :created, location: @shop }
			else
				format.html { render :new }
				format.json { render json: @shop.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /shops/1
	# PATCH/PUT /shops/1.json
	def update
		respond_to do |format|
			if @shop.update(shop_params)
				format.html { redirect_to @shop, notice: 'Tienda actualizada exitosamente.' }
				format.json { render :show, status: :ok, location: @shop }
			else
				format.html { render :edit }
				format.json { render json: @shop.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /shops/1
	# DELETE /shops/1.json
	def destroy
		@shop.destroy
		respond_to do |format|
			format.html { redirect_to shops_url, notice: 'Tienda eliminada exitosamente.' }
			format.json { head :no_content }
		end
	end

	private

	def set_shop
		@shop = Shop.find(params[:id])
	end

	def is_published?
		return redirect_to root_path unless @shop.is_published?
	end

	def require_permission
		unless current_user.admin?
			if (current_user.id != @shop.user_id)
				redirect_to root_path
				# Or do something else here
			end
		end
	end

	def require_permission_destroy
		if current_user.admin?
			@shop.destroy
		elsif current_user.id != @shop.user_id
			redirect_to root_path
			#Or do something else here
		end
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def shop_params
		params.require(:shop).permit(:image, :name, :greeting, :number, :whatsapp, :phone, :user_id, :predio_id, :category_id, :available)
	end
end
