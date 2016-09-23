class UserMailer < ApplicationMailer

	default from: 'notifications@example.com'

	# require 'sendgrid-ruby'
	# include SendGrid

	
 
	def welcome_email(user)
		@user = user
		@url  = 'http://example.com/login'
		mail(to: @user.email, subject: 'Welcome to My Awesome Site')

		# from = Email.new(email: 'test@example.com')
		# subject = 'Hello World from the SendGrid Ruby Library!'
		# to = Email.new(email: 'test@example.com')
		# content = Content.new(type: 'text/plain', value: 'Hello, Email!')
		# mail = Mail.new(from, subject, to, content)

		# sg = SendGrid::API.new(api_key: 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)
		# response = sg.client.mail._('send').post(request_body: mail.to_json)
		# puts response.status_code
		# puts response.body
		# puts response.headers
	end

	def email_to_me(item, email)
		@item = item
		@url = item_art_url(item.id)
		mail(to: email, subject: 'Welcome to My Awesome Site')

	end
  
end
