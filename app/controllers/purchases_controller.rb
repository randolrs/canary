class PurchasesController < ApplicationController

	def show
		
    	@purchase = Purchase.find(params[:id])

  	end

  	def confirmation

  		@purchase = Purchase.find(params[:purchase_id])


  	end


end
