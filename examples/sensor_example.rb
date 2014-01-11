require './lib/lodo'

board = Lodo::Board.new

color = {
  red: 255,
  blue: 0,
  green: 0
}


# loop do
#   board.reset

#   3.times do |x|
#     3.times do |y|
#       if board.pressed? x, y
#         board.draw_pixel(x, y, color)
#       end
#     end
#   end

#   board.save

#   sleep 0.07
# end

loop do
  16.times do |num|
    print Lodo::Core.check_pressed(num).to_i.to_s + " "
  end

  puts "--"
  sleep 0.1
end
