require 'sendgrid-ruby'
include SendGrid

from = Email.new(email: "sabrina_jahan@hotmail.com")
	to = Email.new(email: "sabrina_jahan@hotmail.com")
	subject = "hello"
	content = Content.new(type: "good morning")
	mail = Mail.new(from, subject, to, content)

	sg = SendGrid::API.new(api_key: 'SENDGRID_API_KEY')
	response = sg.client.mail._('send').post(request_body: mail.to_json)
	# puts response.status_code
	# puts response.body
	# puts response.headers