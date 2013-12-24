require 'sinatra/base'
require 'json'

module Lodo
  class CoreSimulator::Server < Sinatra::Base
    set :views, Proc.new { File.join(root, "..", "..", "..", "templates") }

    set :bind, '0.0.0.0'
    set :port, 1337

    get '/' do
      erb :simulator
    end

    get '/lights' do
      Lodo::CoreSimulator.lights.to_json
    end
  end
end