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

    get '/sensor' do
      if params[:val].to_i == 1
        sensor_value = true
      else
        sensor_value = false
      end

      Lodo::CoreSimulator.set_sensors(params[:x].to_i, params[:y].to_i, sensor_value)
    end
  end
end