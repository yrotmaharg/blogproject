require 'sinatra'
require 'haml'
require 'sinatra/activerecord'

configure(:development){ set :database, "sqlite3:///twitterclone.sqlite3" }
#set is a method,so don't forget a space (or parenthesis)

require 'bundler/setup'
require 'sinatra/base'
require 'rack-flash'
require 'rake'
require 'bcrypt'

require './models'

enable :sessions
use Rack::Flash, :sweep => true
set :sessions => true

get '/' do
	haml :home
end

get '/users/new' do
	haml :sign_up
end

post '/users/new' do
	@user = User.new(params['user'])
	if @user.save
		flash[:notice] = "Ya done signed up successfully, pardner!"
		redirect '/'
	else
		 flash[:alert] = "Galdang, now that dint work!"
		 redirect '/users/new'
  	end
end

get '/sign_in' do
	haml :sign_in
end

get '/users/:id' do
	User.find(params[:id])
	haml :profile
end

get '/blog' do
	haml :blog
end

get '/sign_out' do
	redirect '/'
end
# sign up, sign in, sign out(redirect), home, layout