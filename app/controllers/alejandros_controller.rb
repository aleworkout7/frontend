class AlejandrosController < ApplicationController
  before_action :set_alejandro, only: [:show, :edit, :update, :destroy]

  # GET /alejandros
  # GET /alejandros.json
  def index
    if user_signed_in? 
      if current_user.email == "ale@ale.cl"
        @alejandros = Alejandro.all
      else
        redirect_to shops_path
      end
    else
      redirect_to shops_path
    end
  
  end

  # GET /alejandros/1
  # GET /alejandros/1.json
  def show
  end

  # GET /alejandros/new
  def new
    if user_signed_in? 
      if current_user.email == "ale@ale.cl"
        @alejandro = Alejandro.new
        @members = Member.all
      else
        redirect_to shops_path
      end
    else
      redirect_to shops_path
    end
  end

  # GET /alejandros/1/edit
  def edit
    if user_signed_in? 
      if current_user.email == "ale@ale.cl"
        @members = Member.all
      else
        redirect_to shops_path
      end
    else
      redirect_to shops_path
    end
  end

  # POST /alejandros
  # POST /alejandros.json
  def create
    @alejandro = Alejandro.new(alejandro_params)

    respond_to do |format|
      if @alejandro.save
        format.html { redirect_to @alejandro, notice: 'Alejandro was successfully created.' }
        format.json { render :show, status: :created, location: @alejandro }
      else
        format.html { render :new }
        format.json { render json: @alejandro.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alejandros/1
  # PATCH/PUT /alejandros/1.json
  def update
    respond_to do |format|
      if @alejandro.update(alejandro_params)
        format.html { redirect_to @alejandro, notice: 'Alejandro was successfully updated.' }
        format.json { render :show, status: :ok, location: @alejandro }
      else
        format.html { render :edit }
        format.json { render json: @alejandro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alejandros/1
  # DELETE /alejandros/1.json
  def destroy
    @alejandro.destroy
    respond_to do |format|
      format.html { redirect_to alejandros_url, notice: 'Alejandro was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alejandro
      @alejandro = Alejandro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alejandro_params
      params.require(:alejandro).permit(:email, :payment, :payment_date, :due_date, :message, :member_id)
    end
end
