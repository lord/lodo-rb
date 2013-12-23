module Lodo
  class Board
    def initialize
      @string = String.new
      @string.reset
    end

    def set(x,y,color)
      @string[translate_to_linear(x,y)] = color
    end

    def save
      @string.push
    end

    def reset
      @string.reset
    end

    private
    def translate_to_linear(x,y)
      if x % 2 == 0
        (8 - x) * 9 + (8 - y) + 16
      else
        (8 - x) * 9 + (y) + 16
      end
    end
  end
end
