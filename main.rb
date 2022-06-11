require 'sinatra'
require 'sinatra/reloader'

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
  erb :profile
end