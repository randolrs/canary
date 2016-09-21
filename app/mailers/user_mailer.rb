class UserMailer < ApplicationMailer

	default from: 'notifications@example.com'
 
	def welcome_email(user)
		@user = user
		@url  = 'http://example.com/login'
		mail(to: @user.email, subject: 'Welcome to My Awesome Site')
	end

	def email_to_me(item, email)
		@item = item
		@url = item_art_url(item.id)
		mail(to: email, subject: 'Welcome to My Awesome Site')

	end
  
end
