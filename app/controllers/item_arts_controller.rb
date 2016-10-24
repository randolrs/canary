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

    @page_title = "Artwork"

    @view.update(:item_art_id => @item_art.id, :visitor_ip => request.remote_ip)

    @view.save

    @message = Message.new

    @message_recipient = @item_art.user

    @artist = @item_art.user

    @more_work_from_artist = @artist.more_work(@item_art.id, 3)

  end

  def direct_link

    @item_art = ItemArt.search(params[:search_code].downcase)

    if @item_art

      @view = View.new

      @page_title = @item_art.name + " by " + @item_art.user.display_name

      @main_SEO_title = @page_title

      @view.update(:item_art_id => @item_art.id, :visitor_ip => request.remote_ip)

      @view.save

      @message = Message.new

      @message_recipient = @item_art.user

      @artist = @item_art.user

      @more_work_from_artist = @artist.more_work(@item_art.id, 3)



    else

      redirect_to root_path

    end

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

    @hide_add_artwork_cta = true
  end

  # GET /item_arts/1/edit
  def edit
  end

  # POST /item_arts
  # POST /item_arts.json
  def create
    
    if current_user.is_artist

      @item_art = ItemArt.new(item_art_params)

      @item_art.update(:user_id => current_user.id)

      c = 0
      
      until c==1 do
        
        search_code = (SecureRandom.hex(2)).downcase
        
        unless ItemArt.where(:search_code => search_code).exists?

          @item_art.update(:search_code => search_code)

          c=1

        end

      end

      respond_to do |format|
        if @item_art.save
          format.html { redirect_to item_art_detail_form_path(@item_art.id), notice: 'Item art was successfully created.' }
          format.json { render :show, status: :created, location: @item_art }
        else
          format.html { render :new }
          format.json { render json: @item_art.errors, status: :unprocessable_entity }
        end
      end

    else

      redirect_to root_path
    end
  end

  def detail_form
    
    if user_signed_in?
      
      if params[:id]
        
        @item_art = ItemArt.find(params[:id])

      else

        redirect_to root_path

      end
      
      if @item_art.user_id == current_user.id
      
        @return_home_only = true

        @page_title = "Artwork Details"

        @main_SEO_title = @page_title

        @last_pickup_instructions = current_user.last_pickup_instructions

      else

        redirect_to root_path

      end

    else

      redirect_to root_path

    end

  end

  # PATCH/PUT /item_arts/1
  # PATCH/PUT /item_arts/1.json
  def update
    respond_to do |format|
      if @item_art.update(item_art_params)
        format.html { redirect_to root_path, notice: 'Item art was successfully updated.' }
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
      params.require(:item_art).permit(:user_id, :description, :name, :height, :width, :length, :venue_id, :price, :search_code, :image, :exhibition_id, :medium, :is_visible, :is_sample, :sample_name, :pickup_instructions)
    end
end
