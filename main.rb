     
require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'pg'

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
	if @user = User.find_by(email: params[:email] = [])
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
	else redirect '/login'
	end
end

get '/users' do
	@user = User.find(session[:user_id])
	@publications = Publication.where(user_id: session[:user_id])
	@research_fields = ResearchField.all
	@comments = Comment.where(user_id: session[:user_id])
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
	@publications = Publication.joins(:user => :research_field).where("title LIKE ?", "%#{params[:keywords]}%").where("research_fields.id = ?", params[:research_field_id])
	erb :search
end

delete '/users/:id' do
	user = User.find(session[:user_id])
	publications = Publication.where(user_id: session[:user_id])
	user.destroy
	publications.each do |publication|
	publication.destroy
	end
	redirect '/'
end

post '/comments/:id' do
	# comment = Comments.find(user_id: params[:user_id])
	comment = Comment.new
	comment.body = params[:body]
	comment.user_id = params[:id]
	comment.session_id = session[:user_id]
	comment.save
	@user = User.find(params[:id])
	@publications = Publication.where(user_id: params[:id])
	erb :display
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






