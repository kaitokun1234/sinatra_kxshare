require 'sinatra'
require 'sinatra/reloader'
require "sinatra/activerecord"
require "sinatra/flash"

enable :sessions

ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: './db/database.db',
)

class Subject < ActiveRecord::Base
end

class Profile < ActiveRecord::Base
end

get '/management' do
  @sbjs = Subject.all
  erb :management
end

get'/' do
  @title = "Post"
  erb :prediction
end

get '/prediction' do
  @title = "Post"
  erb :prediction
end

get '/buy' do
  @title = "Buy"
  erb :buy
end

get '/suggest' do
  @title = "Suggest"
  erb :suggest
end

get '/ranking' do
  @title = "Ranking"
  erb :ranking
end

get '/product/:id' do
  @id = params[:id]
  erb :product
end

get '/profile/:address' do
  @addr = params[:address]
  @prof = Profile.find_by(addr: @addr)
  erb :profile
end

post '/create_subject' do
 Subject.create(
  content: params[:content]
 )
 flash[:success] = "Successfully sended! thank you for suggestion!!"
 redirect '/'
end

get '/edit_profile/:address' do
  @addr = params[:address]
  erb :edit_profile
end

patch '/edit_profile/:address' do
  #@prof = Profile.find_or_create_by(addr: params[:address])
  @prof = Profile.find_by(addr: params[:address])
  @prof.name = params[:name],
  @prof.comment = params[:comment]
  @prof.save
  flash[:success] = "Successfully edited your profile!"
  redirect '/profile/#{@addr}'
end