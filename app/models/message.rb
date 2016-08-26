class Message < ActiveRecord::Base

	def sender

		@sender = User.where(:id => self.sender_id).first
		
		if @sender

			return @sender

		else

			return nil

		end
	end


	def recipient

		@recipient = User.where(:id => self.recipient_id).first
		
		if @recipient

			return @recipient

		else

			return nil

		end


	end
end
