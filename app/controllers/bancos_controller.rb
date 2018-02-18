class BancosController < ApplicationController
	before_action :check_if_user_is_logged_in
	before_action :set_banco, only: [:show, :edit, :update, :destroy]

	# GET /bancos
	# GET /bancos.json
	def index
		@bancos = Banco.all
	end

	# GET /bancos/1
	# GET /bancos/1.json
	def show
	end

	# GET /bancos/new
	def new
		@banco = Banco.new
	end

	# GET /bancos/1/edit
	def edit
		@bancos = Banco.all
	end

	# POST /bancos
	# POST /bancos.json
	def create
		@banco = Banco.new(banco_params)

		respond_to do |format|
			if @banco.save
				format.html { redirect_to @banco, notice: 'Banco was successfully created.' }
				format.json { render :show, status: :created, location: @banco }
			else
				format.html { render :new }
				format.json { render json: @banco.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /bancos/1
	# PATCH/PUT /bancos/1.json
	def update
		respond_to do |format|
			if @banco.update(banco_params)
				format.html { redirect_to @banco, notice: 'Banco was successfully updated.' }
				format.json { render :show, status: :ok, location: @banco }
			else
				format.html { render :edit }
				format.json { render json: @banco.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /bancos/1
	# DELETE /bancos/1.json
	def destroy
		@banco.destroy
		respond_to do |format|
			format.html { redirect_to bancos_url, notice: 'Banco was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private

	def check_if_user_is_logged_in
		return redirect_to new_user_session_path unless user_signed_in?
		return redirect_to root_path unless current_user.admin?
	end

	def set_banco
		@banco = Banco.find(params[:id])
	end

	def banco_params
		params.require(:banco).permit(:name)
	end
end
