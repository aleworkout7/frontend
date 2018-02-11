class PrediosController < ApplicationController
  before_action :set_predio, only: [:show, :edit, :update, :destroy]

  # GET /predios
  # GET /predios.json
  def index
    if user_signed_in?
      if current_user.email == "ale@ale.cl"
        @predios = Predio.all
      else
        redirect_to shops_path
      end
    else
      redirect_to shops_path
    end
  end

  # GET /predios/1
  # GET /predios/1.json
  def show
  end

  # GET /predios/new
  def new
    if user_signed_in?
      if current_user.email == "ale@ale.cl"
        @predio = Predio.new
      else
        redirect_to shops_path
      end
    else
      redirect_to shops_path
    end
  end

  # GET /predios/1/edit
  def edit
    if user_signed_in?
      if current_user.email == "ale@ale.cl"
        @predios = Predio.all
      else
        redirect_to shops_path
      end
    else
      redirect_to shops_path
    end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_predio
      @predio = Predio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def predio_params
      params.require(:predio).permit(:name, :address, :details)
    end
end
