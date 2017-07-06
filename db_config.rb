require 'active_record'

options = {
	adapter: 'postgresql',
	database: 'connectingresearch',
	username: 'saloni'
}

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || options)
