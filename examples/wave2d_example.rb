require './lib/lodo'

ROW_COUNT = 9
COL_COUNT = 9
COLOR_COUNT = 18

board = Lodo::Board.new

brightness = 0
going_up = true
possibilities = [
  {r: 0.6, g: 0, b: 0},
  {r: 0, g: 0.6, b: 0},
  {r: 0, g: 0, b: 0.6},
  {r: 0, g: 0.6, b: 0.6},
  {r: 0.6, g: 0, b: 0.6},
  {r: 0.3, g: 0, b: 0.6},
  {r: 0.6, g: 0.6, b: 0},
  {r: 0.6, g: 0.6, b: 0.6}
]
color = possibilities.sample
colors = []

COLOR_COUNT.times do
  colors.push(red: 0, green: 0, blue: 0)
end

loop do
  colors.unshift(red: brightness.abs * color[:r], green: brightness.abs * color[:g], blue: brightness.abs * color[:b])
  # limit colors size
  colors = colors[0..COLOR_COUNT]

  ROW_COUNT.times do |y|
    COL_COUNT.times do |x|
      board.set(x, y, colors[x + y])
    end
  end

  board.save

  if going_up
    brightness += 20
    if brightness > 255
      going_up = false
      brightness = 255
    end
  else
    brightness -= 20
    if brightness < 0
      going_up = true
      brightness = 0
      color = possibilities.sample
    end
  end

  sleep 0.03
end
