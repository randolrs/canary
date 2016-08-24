class ItemArtsController < ApplicationController
  before_action :set_item_art, only: [:show, :edit, :update, :destroy]

  # GET /item_arts
  # GET /item_arts.json
  def index
    @item_arts = ItemArt.all
  end

  # GET /item_arts/1
  # GET /item_arts/1.json
  def show
  end

  # GET /item_arts/new
  def new
    @item_art = ItemArt.new
  end

  # GET /item_arts/1/edit
  def edit
  end

  # POST /item_arts
  # POST /item_arts.json
  def create
    @item_art = ItemArt.new(item_art_params)

    respond_to do |format|
      if @item_art.save
        format.html { redirect_to @item_art, notice: 'Item art was successfully created.' }
        format.json { render :show, status: :created, location: @item_art }
      else
        format.html { render :new }
        format.json { render json: @item_art.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_arts/1
  # PATCH/PUT /item_arts/1.json
  def update
    respond_to do |format|
      if @item_art.update(item_art_params)
        format.html { redirect_to @item_art, notice: 'Item art was successfully updated.' }
        format.json { render :show, status: :ok, location: @item_art }
      else
        format.html { render :edit }
        format.json { render json: @item_art.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_arts/1
  # DELETE /item_arts/1.json
  def destroy
    @item_art.destroy
    respond_to do |format|
      format.html { redirect_to item_arts_url, notice: 'Item art was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_art
      @item_art = ItemArt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_art_params
      params.require(:item_art).permit(:user_id, :description, :name, :height, :width, :length, :venue_id, :price, :search_code, :image, :exhibition_id, :medium)
    end
end
