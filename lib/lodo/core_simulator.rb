dir = File.dirname(__FILE__)
$LOAD_PATH.unshift dir unless $LOAD_PATH.include?(dir)

module Lodo
  module CoreSimulator

    LIGHT_ROWS = 9
    LIGHT_COLS = 9

    # SIMULATED FUNCTIONS
    ##########################

    def self.spi_init(int)
      @@lights = []
      0
    end

    def self.tcl_init(pointer, max_leds)
      @@buffer = []
      @@max_leds = max_leds
      0
    end

    def self.open_device
      1337
    end

    def self.close_device(int)
      return nil
    end

    def self.set_gamma(*args)
      nil
    end

    def self.write_color_to_buffer(pointer, position, red, green, blue)
      if position < @@max_leds
        @@buffer[position] = {r: red, g: green, b: blue}
      else
        puts "WARNING: Write to outside of buffer."
      end
      nil
    end

    def self.send_buffer(*args)
      @@lights = @@buffer.dup
      0
    end

    class self::Buffer
      def pointer
        1337
      end
    end

    # BACKEND FUNCTIONS FOR SERVER
    ##################################

    def self.start_server
      server_thread = Thread.new { Lodo::CoreSimulator::Server.run! }
      Thread.new {
        until Lodo::CoreSimulator::Server.running?
          sleep 1
        end
        trap("INT") {puts "Exiting..."; exit}
        puts "Trap registered"
      }
    end

    def self.lights
      @@lights
    end


    class << self
      alias_method :write_gamma_color_to_buffer, :write_color_to_buffer
    end
  end
end

require 'core_simulator/server'

Lodo::CoreSimulator.start_server
