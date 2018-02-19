class QueriesController < ApplicationController
	before_action :set_query, only: [:show, :edit, :update, :destroy]

	# GET /queries
	# GET /queries.json
	def index
		@queries = Query.all
	end

	# GET /queries/1
	# GET /queries/1.json
	def show
		redirect_to queries_path
	end

	# GET /queries/new
	def new
		redirect_to queries_path
	end

	# GET /queries/1/edit
	def edit
		redirect_to queries_path
	end

	# POST /queries
	# POST /queries.json
	def create
		@contact = Contact.new(contact_params)

		respond_to do |format|
			if @contact.save
				format.html { redirect_to queries_path, notice: 'Seu contato foi enviado com sucesso. Logo entraremos em contato com você.' }
				format.json { render :show, status: :created, location: @contact }
			else
				format.html { render :index }
				format.json { render json: @contact.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /queries/1
	# PATCH/PUT /queries/1.json
	def update
		respond_to do |format|
			if @query.update(query_params)
				format.html { redirect_to @query, notice: 'Query was successfully updated.' }
				format.json { render :show, status: :ok, location: @query }
			else
				format.html { render :edit }
				format.json { render json: @query.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /queries/1
	# DELETE /queries/1.json
	def destroy
		@query.destroy
		respond_to do |format|
			format.html { redirect_to queries_url, notice: 'Query was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_query
		@query = Query.find(params[:id])
	end

	def query_params
		params.fetch(:query, {})
	end

	def contact_params
		params.require(:contact).permit(:email, :phone, :city, :comment)
	end
end
