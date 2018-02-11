class PagosController < ApplicationController
  before_action :set_pago, only: [:show, :edit, :update, :destroy]

  # GET /pagos
  # GET /pagos.json
  def index
    @user = User.all
    if user_signed_in?
      @pagos = Pago.where(:user_id => current_user.id)
      @todos_pagos = Pago.all
    else
      redirect_to shops_path
    end
  end

  # GET /pagos/1
  # GET /pagos/1.json
  def show
  end

  # GET /pagos/new
  def new
    @pago = Pago.new
    @members = Member.all
    @bancos = Banco.all
    @cuentas = Account.all
  end

  # GET /pagos/1/edit
  def edit
    @members = Member.all
    @bancos = Banco.all
    @cuentas = Account.all    
  end

  # POST /pagos
  # POST /pagos.json
  def create
    @pago = Pago.new(pago_params)
    @pago.checked = false
    @pago.user_id = current_user.id
    @pago.email = current_user.email
    @pago.notice_date = Date.today
    respond_to do |format|
      if @pago.save
        format.html { redirect_to @pago, notice: 'Pago was successfully created.' }
        format.json { render :show, status: :created, location: @pago }
      else
        format.html { render :new }
        format.json { render json: @pago.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pagos/1
  # PATCH/PUT /pagos/1.json
  def update
    respond_to do |format|
      if @pago.update(pago_params)
        format.html { redirect_to @pago, notice: 'Pago was successfully updated.' }
        format.json { render :show, status: :ok, location: @pago }
      else
        format.html { render :edit }
        format.json { render json: @pago.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pagos/1
  # DELETE /pagos/1.json
  def destroy
    @pago.destroy
    respond_to do |format|
      format.html { redirect_to pagos_url, notice: 'Pago was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pago
      @pago = Pago.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pago_params
      params.require(:pago).permit(:account_number ,:banco_id, :account_id, :image, :user_id, :member_id, :payment_date, :amount, :message, :checked, :predio_name, :predio_address, :email, :notice_date)
    end
end
