class ExhibitionsController < ApplicationController
  before_action :set_exhibition, only: [:show, :edit, :update, :destroy]

  # GET /exhibitions
  # GET /exhibitions.json
  def index
    @exhibitions = Exhibition.all
  end

  # GET /exhibitions/1
  # GET /exhibitions/1.json
  def show
  end

  # GET /exhibitions/new
  def new
    @exhibition = Exhibition.new
  end

  
  def setup

    @exhibition = Exhibition.new

  end

  # GET /exhibitions/1/edit
  def edit
  end

  # POST /exhibitions
  # POST /exhibitions.json
  def create
    
    if user_signed_in?

      @exhibition = Exhibition.new(exhibition_params)

      @exhibition.update(:user_id => current_user.id)

      respond_to do |format|
        if @exhibition.save
          format.html { redirect_to @exhibition, notice: 'Exhibition was successfully created.' }
          format.json { render :show, status: :created, location: @exhibition }
        else
          format.html { render :new }
          format.json { render json: @exhibition.errors, status: :unprocessable_entity }
        end
      end

    else

      redirect_to root_path

    end
  end

  # PATCH/PUT /exhibitions/1
  # PATCH/PUT /exhibitions/1.json
  def update
    respond_to do |format|
      if @exhibition.update(exhibition_params)
        format.html { redirect_to @exhibition, notice: 'Exhibition was successfully updated.' }
        format.json { render :show, status: :ok, location: @exhibition }
      else
        format.html { render :edit }
        format.json { render json: @exhibition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exhibitions/1
  # DELETE /exhibitions/1.json
  def destroy
    @exhibition.destroy
    respond_to do |format|
      format.html { redirect_to exhibitions_url, notice: 'Exhibition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exhibition
      @exhibition = Exhibition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exhibition_params
      params.require(:exhibition).permit(:user_id, :city_id, :venue_name, :address_line_1, :address_line_2, :state_or_province, :zip_or_postal_code, :country, :start_date, :end_date)
    end
end
