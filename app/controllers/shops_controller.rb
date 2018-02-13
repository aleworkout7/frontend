class ShopsController < ApplicationController
	before_action :set_shop, only: [:show, :edit, :update, :destroy]
	before_action :require_permission, only: :edit
	before_action :require_permission_destroy, only: :destroy

	# GET /shops
	# GET /shops.json
	def index
		@my_shops = Shop.select(:predio_id).order(:predio_id).distinct
	end

	def predio
		@predio = Predio.find(params[:id])
		@shops = Shop.search({ predio_id: @predio.id, search: params[:search] }).published
	end

	# GET /shops/1
	# GET /shops/1.json
	def show
		@q = Product.ransack(params[:q])
		@products = @q.result(distinct: true)
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
		@shop.predio_id = 1
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
	# Use callbacks to share common setup or constraints between actions.
	def set_shop
		@shop = Shop.find(params[:id])
	end

	def require_permission
		if current_user.email != "ale@ale.cl"
			if (current_user.id != Shop.find(params[:id]).user_id)
				redirect_to root_path
				# Or do something else here
			end
		end
	end

	def require_permission_destroy
		if current_user.email == "ale@ale.cl"
			@shop.destroy
		elsif current_user.id != Shop.find(params[:id]).user_id
			redirect_to root_path
			#Or do something else here
		end
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def shop_params
		params.require(:shop).permit(:image, :name, :greeting, :number, :whatsapp, :phone, :user_id, :predio_id, :category_id, :available)
	end
end
