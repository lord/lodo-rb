require 'sinatra'
require './lib/lodo'

board = Lodo::Board.new

set :bind, '0.0.0.0'

get '/' do
  board.reset
  erb :remote
end

get '/set' do
  board.set(params[:x].to_i, params[:y].to_i, {red: params[:r].to_i, green: params[:g].to_i, blue: params[:b].to_i})
  board.save
  "OK"
end
