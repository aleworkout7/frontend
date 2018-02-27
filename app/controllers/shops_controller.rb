class ShopsController < ApplicationController
	before_action :set_predio
	before_action :set_shop, only: [:show, :edit, :update, :destroy]
	before_action :is_user_authorized?, only: [:new, :edit, :create, :update]
	before_action :is_published?, only: [:show]

	# GET /predios/:predio_id/shops
	def index
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
		@categories = Category.all
	end

	# GET /shops/1/edit
	def edit
		@categories = Category.all
	end

	# POST /shops
	# POST /shops.json
	def create
		@shop = Shop.new(shop_params)
		@shop.user_id = current_user.id if current_user
		respond_to do |format|
			if @shop.save
				format.html { redirect_to predio_shop_path(@predio, @shop), notice: 'Loja criada com successo.' }
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
				format.html { redirect_to predio_shop_path(@predio, @shop), notice: 'Loja atualizada com successo.' }
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
		if current_user.admin? || current_user.is_my_shop?(@shop)
			@shop.destroy
		end

		respond_to do |format|
			format.html { redirect_to predio_shops_path(@predio), notice: 'Loja excluida com successo.' }
			format.json { head :no_content }
		end
	end

	private
	def set_predio
		@predio = Predio.find(params[:predio_id])
	end

	def set_shop
		@shop = Shop.find(params[:id])
	end

	def is_user_authorized?
		return redirect_to pagos_path unless current_user.has_subscription?
	end

	def is_published?
		return redirect_to root_path unless @shop.is_published?
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def shop_params
		params.require(:shop).permit(:image, :name, :user_id, :predio_id, :category_id, :available)
	end
end
