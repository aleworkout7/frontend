class PrediosController < ApplicationController
	before_action :check_if_user_is_logged_in, except: [ :home, :shops, :search ]
	before_action :set_predio, only: [:shops, :show, :edit, :update, :destroy]

	# GET /
	def home
		unless user_signed_in?
			return redirect_to new_user_registration_path
		end
		@predios = Predio.highlighteds
	end

	# GET /search
	def search
		if params[:search].present?
			@predios = Predio.search(params[:search])
		else
			@predios = Predio.highlighteds
		end

		render layout: false
	end

	# GET /predios
	# GET /predios.json
	def index
		@predios = Predio.all
	end

	# GET /predios/1
	# GET /predios/1.json
	def show
	end

	# GET /predios/new
	def new
		@housings = HousingSet.all
		@predio = Predio.new
	end

	# GET /predios/1/edit
	def edit
		@housings = HousingSet.all
		@predios = Predio.all
	end

	# POST /predios
	# POST /predios.json
	def create
		@predio = Predio.new(predio_params)

		respond_to do |format|
			if @predio.save
				format.html { redirect_to @predio, notice: 'Predio was successfully created.' }
				format.json { render :show, status: :created, location: @predio }
			else
				format.html { render :new }
				format.json { render json: @predio.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /predios/1
	# PATCH/PUT /predios/1.json
	def update
		respond_to do |format|
			if @predio.update(predio_params)
				format.html { redirect_to @predio, notice: 'Predio was successfully updated.' }
				format.json { render :show, status: :ok, location: @predio }
			else
				format.html { render :edit }
				format.json { render json: @predio.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /predios/1
	# DELETE /predios/1.json
	def destroy
		@predio.destroy
		respond_to do |format|
			format.html { redirect_to predios_url, notice: 'Predio was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private

	def set_predio
		@predio = Predio.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def predio_params
		params.require(:predio).permit(:name, :address, :details, :is_highlight, :image, :housing_set_id)
	end
end
