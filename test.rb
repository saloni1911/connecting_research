require 'sendgrid-ruby'
include SendGrid

from = Email.new(email: "saloni.1911@gmail.com")
	to = Email.new(email: "saloni.1911@gmail.com")
	subject = "hello"
	content = Content.new(type: "good morning")
	mail = Mail.new(from, subject, to, content)

	sg = SendGrid::API.new(api_key: "OfPcIsFBRg-LvZ51ixwygw.3W-hnEwIMt2bPXeJQZfD5iudlLKbyDVw_wnwYFKBVjs")
	response = sg.client.mail._('send').post(request_body: mail.to_json)
	# puts response.status_code
	# puts response.body
	# puts response.headers