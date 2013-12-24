require 'sinatra/base'
require 'json'

module Lodo
  class CoreSimulator::Server < Sinatra::Base
    configure do
      set :views, Proc.new { File.join(root, "..", "..", "..", "templates") }
      set :bind, '0.0.0.0'
      set :port, 1337
    end

    before { env['rack.logger'] = './app.error.log'  }

    get '/' do
      erb :simulator
    end

    get '/lights' do
      Lodo::CoreSimulator.lights.to_json
    end
  end
end