require './lib/lodo'

board = Lodo::Board.new

x = 0
y = 0

color = {
  red: 255,
  blue: 0,
  green: 0
}


loop do
  board.reset
  board.draw_pixel(x, y, color)
  board.save

  x += 1

  if x > 8
    x = 0
    y += 1
  end

  if y > 8
    y = 0
  end

  sleep 0.07
end
