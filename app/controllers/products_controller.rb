class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  
  def index
    redirect_to shops_path
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end

  def show
  
  end


  def new
    @shops = current_user.shops
    @product = Product.new
  end

  def edit
    @shops = current_user.shops
  end

  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id if current_user
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Producto creado exitosamente.' }
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
        format.html { redirect_to @product, notice: 'Producto actualizado exitosamente.' }
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
      format.html { redirect_to products_url, notice: 'Producto eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:image, :name, :price, :detail, :shop_id)
    end
end
