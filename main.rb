     
require 'sinatra'
require 'sinatra'
#require 'sinatra/reloader'
require 'pry'
require 'sendgrid-ruby'
require 'pg'
include SendGrid

require_relative 'db_config'
require_relative 'models/user'
require_relative 'models/research_field'
require_relative 'models/publication'
require_relative 'models/comment'


helpers do 

	def logged_in?
		if current_user
			true
		else
			false
		end

	end

	def current_user
		User.find_by(id: session[:user_id])
	end

end

enable :sessions

get '/' do
  erb :index
end

get'/login' do
	erb :login
end

post '/session' do
	user = User.find_by(email: params[:email])
	if user && user.authenticate(params[:password])
		session[:user_id] = user.id
		redirect '/users'
	else
		#erb :login
		erb :index
	end
end

delete '/session' do
	session[:user_id] = nil
	redirect '/'
end


get '/new' do
	@research_fields = ResearchField.all
	erb :new
end

post '/users' do
	user = User.new
	user.name = params[:name]
	user.email = params[:email]
	user.password = params[:password]
	user.location = params[:location]
	user.degree = params[:degree]
	user.research_institute = params[:research_institute]
	user.research_field_id = params[:research_field_id]
	user.save

	redirect '/login'
end

get '/users' do
	# @users = User.all
	@user = User.find(session[:user_id])
	#@publications = Publication.all
	@publications = Publication.where(user_id: session[:user_id])
	@research_fields = ResearchField.all
	erb :users
end

get '/addpublications' do
	erb :addpublications
end

post '/publications' do
	publication = Publication.new
	publication.title = params[:title]
	publication.url = params[:url]
	publication.authors = params[:authors]
	publication.journal_name = params[:journal_name]
	publication.user_id = session[:user_id]
	publication.publication_date = params[:date]
	publication.save

	redirect '/users'
end

get '/search' do
	# @user = User.where(research_field_id: params[:research_field_id])
	# @publications = Publication.where("title LIKE ?", "%#{params[:keywords]}%")
@publications = Publication.joins(:user => :research_field).where("title LIKE ?", "%#{params[:keywords]}%").where("research_fields.id = ?", params[:research_field_id])
	erb :search
end

get '/users/:id' do
	@user = User.find(params[:id])
	@publications = Publication.where(user_id: params[:id])
	erb :display
end

get '/edit' do
	@user = User.find(session[:user_id])
	@research_fields = ResearchField.all
	erb :edit
end

patch '/users' do
	user = User.find(session[:user_id])
	user.name = params[:name]
	user.email = params[:email]
	user.password = params[:password]
	user.location = params[:location]
	user.degree = params[:degree]
	user.research_institute = params[:research_institute]
	user.research_field_id = params[:research_field_id]
	user.save

	redirect '/users'
end


get '/messages' do
	# sg = SendGrid::API.new(api_key: ENV["SENDGRID_API_KEY"])
	# response = sg.client.mail._('send').post(request_body: mail.to_json)
	
	# from = Email.new(email: 'saloni.1911@gmail.com')
	# to = Email.new(email: 'akashrtulsiyan@gmail.com')
	# subject = 'Sending with SendGrid is Fun'
	# content = Content.new(type: 'cfjnklm;;lmknhj;n', value: 'and easy to do anywhere, even with Ruby')
	from = Email.new(email: params[session[:user_id]])
	to = Email.new(email: params[:id])
	subject = "#{params[:subject]}"
	content = Content.new(type: params[:content])
	mail = Mail.new(from, subject, to, content)

	sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
	response = sg.client.mail._('send').post(request_body: mail.to_json)
	puts response.status_code
	puts response.body
	puts response.headers
	# from = mail.from['email']
	# subject = mail.subject
	# to = mail.personalizations[0]['to'][0]['email']
	# content = mail.contents[0]['type']

erb :display
end








