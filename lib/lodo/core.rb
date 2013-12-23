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
    attach_function :set_gamma, [:double, :double, :double], :void
    attach_function :write_gamma_color_to_buffer, [:pointer, :int, :uint8, :uint8, :uint8], :void
  end
end