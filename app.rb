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


post '/create_subject' do
 sbj = Subject.new
 sbj.content = params[:content]
 sbj.save!
 flash[:success] = "Successfully sended! thank you for suggestion!!"
 redirect '/'
end

get '/edit_profile/:address' do
  @addr = params[:address]
  erb :edit_profile
end

get '/profile/:address' do
  @addr = params[:address]
  @prof = Profile.find_by(addr: @addr)
  if @prof == nil
    Profile.create!(addr: params[:address])
    redirect "/profile/#{params[:address]}"
  end
  erb :profile
end

patch '/editprofile/:address' do
  @prof = Profile.find_by(addr: params[:address])
  @prof.name = params[:name]
  @prof.comment = params[:comment]
  @prof.save!
  redirect "/profile/#{params[:address]}"
end