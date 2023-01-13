require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require_relative 'lib/peep'
require_relative 'lib/user'

class Chitter < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    @peeps = Peep.all()
    return erb(:index)
  end

  post '/add_peep' do
    
    peep = Peep.new("content": params[:content], "user_id": 1)
    peep.save ? (redirect "/") : "Failed to create a post!"
  end

  get '/login' do
    return erb(:login)
  end

  post '/login' do
    # user authentication
  end

  get '/register' do
    return erb(:register)
  end

  post '/register' do
    user = User.new(
      "username": params[:username],
      "name": params[:name],
      "email": params[:email],
      "password": params[:password]
    )
    # add user to db
    user.save ? (redirect "/") : "Failed to add user!"
  end
end