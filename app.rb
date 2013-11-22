require 'sinatra'
require 'haml'
require 'sinatra/activerecord'

configure(:development){ set :database, "sqlite3:///twitterclone.sqlite3" }
#set is a method,so don't forget a space (or parenthesis)

require 'bundler/setup'
require 'sinatra/base'
require 'rack-flash'
require 'rake'

#require './models'


get '/' do
	'hello world'
end


# sign up, sign in, sign out(redirect), home, layout