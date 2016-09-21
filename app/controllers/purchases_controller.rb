class PurchasesController < ApplicationController

	def show
		
    	@purchase = Purchase.find(params[:id])

    	@item_art = @purchase.item_art

    	@page_title = "My Purchases"

  	end

  	def confirmation

  		@purchase = Purchase.find(params[:purchase_id])

  		#unless @purchase.ip_address == request.remote_ip

  			#redirect_to root_path

  		#end


  	end


end
