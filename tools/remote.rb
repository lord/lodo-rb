require 'sinatra/base'
require './lib/lodo'

class Remote < Sinatra::Base

  board = Lodo::Board.new

  set :views, Proc.new { File.join(root, "..", "templates") }

  set :bind, '0.0.0.0'

  get '/' do
    board.reset
    erb :remote
  end

  get '/set' do
    board.draw_pixel(params[:x].to_i, params[:y].to_i, {red: params[:r].to_i, green: params[:g].to_i, blue: params[:b].to_i})
    board.save
    "OK"
  end

  run!
end