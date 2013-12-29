module Lodo
  class Board
    def initialize
      @string = String.new
      @string.reset
    end

    def draw_pixel(x,y,color)
      @string[translate_to_linear(x,y)] = color
    end

    def save
      @string.save
    end

    def reset
      @string.reset
    end

    def pressed?(*args)
      Core.pressed?(*args)
    end

    private
    def translate_to_linear(x,y)
      # even rows go up, odd rows go down
      if x % 2 == 0
        (8 - x) * 9 + (8 - y) + 16
      else
        (8 - x) * 9 + (y) + 16
      end
    end
  end
end
