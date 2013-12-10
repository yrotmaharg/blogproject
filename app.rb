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

helpers do
  def current_user
    session[:user_id].nil? ? nil : User.find(session[:user_id])
    # this means that during this session, if the user gives back nothing, (it's not the user) then display nothing. If it's the user, then display the options. This is placed inside a helper, so it can be used in the haml files. Otherwise it can only be used in the main app file.
  #you could also code this like this:
  #if session[:user_id]
    #User.find(session[:user_id])
    #else 
    #nil
    #end
  end
  def display_one
    "1"
  end
end

def current_user
  if session[:user_id].nil?
    nil
  else
    User.find(session[:user_id])
  end
end


get '/' do
	haml :home
end

get '/users/new' do
	haml :'users/new'
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

post '/sign_in' do
	@user = User.authenticate(params[:user][:email], params[:user][:password])
	   if @user
      session[:user_id] = @user.id
  		flash[:notice] = 'Welcome!'
  		redirect '/'
  	else
  		flash[:alert] = "Ooops! That didn't work."
  		redirect '/sign_in'
  	end
  end


get '/users/:id' do
	@user = User.find(params[:id])
	haml :'users/show'
end

get '/users/:id/posts/new' do
  @user = User.find(parems[:id])
  if current_user == @user
	 haml :'posts/new'
  else
    redirect '/'
  end
end

get '/users/:user_id/posts/:id' do
  @post = Post.find(params[:id])
  if @post.user_id == params[:user_id].to_i
    haml :'posts/show'
  else
    flash[:alert] = "Your post could not be found."
    redirect '/'
  end
end

post '/users/:id/posts/new' do
  @user = User.find(params[:id])
  if @user == current_user
    @post = Post.new(params[:post])
    if @post.save && @user.posts << @post
      flash[:notice] = "That tidbit was saved."
      redirect "/users/#{@user.id}"
    else
      flash[:alert] = "You done messed that up."
      redirect "/users/#{@user.id}/posts/new"
    end
  else
    redirect '/'
  end
end




get '/sign_out' do
	session[:user_id] = nil
  	flash[:notice] = "You've been successfully signed out."
	redirect '/'
end



#note: << means "add to"
