require 'bundler/setup'
require 'ffi'
require 'benchmark'

module LodoLights
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

  # int leds; /* number of LEDS */
  # size_t size; /* size of buffer */
  # tcl_color *buffer; /* pointer to buffer memory */
  # tcl_color *pixels; /* pointer to start of pixels */

  attach_function :spi_init, [:int], :int
  attach_function :tcl_init, [:pointer, :int], :int
  attach_function :open_device, [], :int
  attach_function :close_device, [:int], :void
  attach_function :write_color_to_buffer, [:pointer, :int, :uint8, :uint8, :uint8], :void
  attach_function :send_buffer, [:int, :pointer], :int
end

class LightString
  LED_COUNT = 25

  def initialize
    @device = LodoLights.open_device
    @buffer = LodoLights::Buffer.new
    @buffer_cache = {} # TODO replace with retrieval from C buffer?
    raise "Device failed to open" if @device <= 0

    spi_status = LodoLights.spi_init(@device)
    raise "SPI failed to start" if spi_status != 0

    tcl_status = LodoLights.tcl_init(@buffer.pointer, LED_COUNT)
    raise "TCL failed to start" if tcl_status != 0
  end

  def []= (led_number, color)
    LodoLights.write_color_to_buffer(@buffer.pointer, led_number, color[:red], color[:green], color[:blue])
    @buffer_cache[led_number] = color
  end

  def [] (led_number)
    @buffer_cache[led_number]
  end

  def push
    LodoLights.send_buffer(@device, @buffer.pointer)
  end

  def each
    LED_COUNT.times do |led_number|
      color = yield(led_number)
      self[led_number] = color
    end
  end

  def reset
    self.each do |light_number|
      {red: 0, green: 0, blue: 0}
    end
    push
  end
end
