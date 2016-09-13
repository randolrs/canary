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

    @view = View.new

    @page_title = "Artagami"

    @view.update(:item_art_id => @item_art.id, :visitor_ip => request.remote_ip)

    @view.save

    @message = Message.new

    @message_recipient = @item_art.user

  end

  def search

    @item_art = ItemArt.search(params[:search])

    if @item_art

      redirect_to @item_art

    else

      redirect_to root_path, flash[:error] => "Item not found."

    end

  end

  # GET /item_arts/new
  def new
    @item_art = ItemArt.new

    @page_title = "Add Artwork"
  end

  # GET /item_arts/1/edit
  def edit
  end

  # POST /item_arts
  # POST /item_arts.json
  def create
    @item_art = ItemArt.new(item_art_params)

    @item_art.update(:user_id => current_user.id)

    c = 0
    
    until c==1 do
      
      search_code = (SecureRandom.urlsafe_base64 3).downcase
      
      unless ItemArt.where(:search_code => search_code).exists?

        @item_art.update(:search_code => search_code)

        c=1

      end

    end

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
