class ProductsController < ApplicationController
	before_action :set_predio
	before_action :set_shop
	before_action :set_product, only: [:show, :edit, :update, :destroy]

	def index
	end

	def show
	end

	def new
		@product = Product.new
	end

	def edit
	end

	def create
		@product = Product.new(product_params)
		@product.user_id = current_user.id if current_user
		respond_to do |format|
			if @product.save
				format.html { redirect_to predio_shop_path(@predio, @shop), notice: 'Producto creado exitosamente.' }
				format.json { render :show, status: :created, location: @product }
			else
				format.html { render :new }
				format.json { render json: @product.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @product.update(product_params)
				format.html { redirect_to edit_predio_shop_product_path(@predio, @shop, @product), notice: 'Producto actualizado exitosamente.' }
				format.json { render :show, status: :ok, location: @product }
			else
				format.html { render :edit }
				format.json { render json: @product.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@product.destroy
		respond_to do |format|
			format.html { redirect_to predio_shop_path(@predio, @shop), notice: 'Producto eliminado exitosamente.' }
			format.json { head :no_content }
		end
	end

	private
	def set_predio
		@predio = Predio.find(params[:predio_id])
	end

	def set_shop
		@shop = Shop.find(params[:shop_id])
	end

	def set_product
		@product = Product.find(params[:id])
	end

	def product_params
		params.require(:product).permit(:image, :name, :price, :detail, :shop_id)
	end
end
