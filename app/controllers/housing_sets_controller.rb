class HousingSetsController < ApplicationController
	before_action :check_if_user_is_logged_in
	before_action :set_housing_set, only: [:show, :edit, :update, :destroy]

	# GET /housing_sets
	# GET /housing_sets.json
	def index
		@housing_sets = HousingSet.all
	end

	# GET /housing_sets/1
	# GET /housing_sets/1.json
	def show
	end

	# GET /housing_sets/new
	def new
		@districts = District.all
		@housing_set = HousingSet.new
	end

	# GET /housing_sets/1/edit
	def edit
		@districts = District.all
	end

	# POST /housing_sets
	# POST /housing_sets.json
	def create
		@housing_set = HousingSet.new(housing_set_params)

		respond_to do |format|
			if @housing_set.save
				format.html { redirect_to housing_sets_path, notice: 'Housing set was successfully created.' }
				format.json { render :show, status: :created, location: @housing_set }
			else
				format.html { render :new }
				format.json { render json: @housing_set.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /housing_sets/1
	# PATCH/PUT /housing_sets/1.json
	def update
		respond_to do |format|
			if @housing_set.update(housing_set_params)
				format.html { redirect_to housing_sets_path, notice: 'Housing set was successfully updated.' }
				format.json { render :show, status: :ok, location: @housing_set }
			else
				format.html { render :edit }
				format.json { render json: @housing_set.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /housing_sets/1
	# DELETE /housing_sets/1.json
	def destroy
		@housing_set.destroy
		respond_to do |format|
			format.html { redirect_to housing_sets_url, notice: 'Housing set was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_housing_set
		@housing_set = HousingSet.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def housing_set_params
		params.require(:housing_set).permit(:name, :district_id)
	end
end
