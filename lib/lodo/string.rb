module Lodo
  class String
    LED_COUNT = 100

    def initialize
      @device = Core.open_device
      @buffer = Core::Buffer.new
      @buffer_cache = {} # TODO replace with retrieval from C buffer?
      raise "Device failed to open" if @device <= 0

      spi_status = Core.spi_init(@device)
      raise "SPI failed to start" if spi_status != 0

      tcl_status = Core.tcl_init(@buffer.pointer, LED_COUNT)
      raise "TCL failed to start" if tcl_status != 0
    end

    def []= (led_number, color)
      Core.write_color_to_buffer(@buffer.pointer, led_number, color[:red], color[:green], color[:blue])
      @buffer_cache[led_number] = color
    end

    def [] (led_number)
      @buffer_cache[led_number]
    end

    def push
      Core.send_buffer(@device, @buffer.pointer)
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
end