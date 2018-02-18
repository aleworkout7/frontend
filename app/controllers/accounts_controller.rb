class AccountsController < ApplicationController
	before_action :check_if_user_is_logged_in
	before_action :set_account, only: [:show, :edit, :update, :destroy]

	# GET /accounts
	# GET /accounts.json
	def index
		@accounts = Account.all
	end

	# GET /accounts/1
	# GET /accounts/1.json
	def show
	end

	# GET /accounts/new
	def new
		@account = Account.new
	end

	# GET /accounts/1/edit
	def edit
		@accounts = Account.all
	end

	# POST /accounts
	# POST /accounts.json
	def create
		@account = Account.new(account_params)

		respond_to do |format|
			if @account.save
				format.html { redirect_to @account, notice: 'Account was successfully created.' }
				format.json { render :show, status: :created, location: @account }
			else
				format.html { render :new }
				format.json { render json: @account.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /accounts/1
	# PATCH/PUT /accounts/1.json
	def update
		respond_to do |format|
			if @account.update(account_params)
				format.html { redirect_to @account, notice: 'Account was successfully updated.' }
				format.json { render :show, status: :ok, location: @account }
			else
				format.html { render :edit }
				format.json { render json: @account.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /accounts/1
	# DELETE /accounts/1.json
	def destroy
		@account.destroy
		respond_to do |format|
			format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private

	def check_if_user_is_logged_in
		return redirect_to new_user_session_path unless user_signed_in?
		return redirect_to root_path unless current_user.admin?
	end

	def set_account
		@account = Account.find(params[:id])
	end

	def account_params
		params.require(:account).permit(:name)
	end
end
