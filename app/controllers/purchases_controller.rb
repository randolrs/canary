class PurchasesController < ApplicationController

	def show
		
    	@purchase = Purchase.find(params[:id])

    	@item_art = @purchase.item_art

    	@page_title = "My Purchases"

  	end

  	def confirmation

  		@purchase = Purchase.find(params[:purchase_id])


  	end


end
