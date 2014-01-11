module Lodo
  module Core
    extend FFI::Library
    ffi_lib "./libtclled.so.1.0.1"

    class Color < FFI::Struct
      layout :flag,  :uint8,
             :blue,  :uint8,
             :green, :uint8,
             :blue,  :uint8
    end

    class Buffer < FFI::Struct
      layout :leds,  :int,
             :size,  :size_t,
             :buffer, :pointer,
             :pixels, :pointer
    end

    attach_function :spi_init, [:int], :int
    attach_function :tcl_init, [:pointer, :int], :int
    attach_function :open_device, [], :int
    attach_function :close_device, [:int], :void
    attach_function :write_color_to_buffer, [:pointer, :int, :uint8, :uint8, :uint8], :void
    attach_function :send_buffer, [:int, :pointer], :int
    attach_function :set_gamma, [:double, :double, :double], :void
    attach_function :write_gamma_color_to_buffer, [:pointer, :int, :uint8, :uint8, :uint8], :void
    attach_function :check_pressed, [:int], :string

    # Placeholder for sensors
    def self.refresh_sensor_data(sensor_count)
      boards = Array.new(3, [])

      sensor_count.times do |sensor_number|
        `echo #{(sensor_number & 1) > 0 ? 1 : 0} > /sys/class/gpio/gpio23/value`
        `echo #{(sensor_number & 2) > 0 ? 1 : 0} > /sys/class/gpio/gpio47/value`
        `echo #{(sensor_number & 4) > 0 ? 1 : 0} > /sys/class/gpio/gpio27/value`
        `echo #{(sensor_number & 8) > 0 ? 1 : 0} > /sys/class/gpio/gpio22/value`

        sensor_blocks[0][sensor_number] = `cat /sys/devices/ocp.2/helper.11/AIN0`.chomp.to_i
        sensor_blocks[1][sensor_number] = `cat /sys/devices/ocp.2/helper.11/AIN1`.chomp.to_i
        sensor_blocks[2][sensor_number] = `cat /sys/devices/ocp.2/helper.11/AIN2`.chomp.to_i
      end
    end
  end
end