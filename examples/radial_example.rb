require './lib/lodo'

COLOR_COUNT = 18

board = Lodo::Board.new

offset = 0.0
spread = 1.3
border_brightness = 0.0
border_brightness_increasing = true
border_brightness_speed = 0.2

distance_table = []

Lodo::LIGHT_COLS.times do |col|
  distance_table[col] = []
  Lodo::LIGHT_ROWS.times do |row|
    distance_table[col][row] = Math.sqrt(((row - 4) ** 2)+((col - 4)) ** 2)
  end
end


loop do
  Lodo::LIGHT_COLS.times do |col|
    Lodo::LIGHT_ROWS.times do |row|
      distance = distance_table[col][row]
      brightness = Math.sin((distance + offset) * spread) * 100
      # puts "(#{row - 4}, #{col-4}, #{distance})"
      # brightness = (distance - 2) * -255 + 255

      # if distance <= 2
      #   board.draw_pixel(col, row, {red: 255, blue: 255, green: 255})
      if brightness <= 0
        board.draw_pixel(col, row, {red: 0, blue: 0, green: 0})
      else
        board.draw_pixel(col, row, {red: brightness.abs.to_i, blue: brightness.abs.to_i, green: brightness.abs.to_i})
      end
    end
  end

  [0,8].each do |col|
    Lodo::LIGHT_ROWS.times do |row|
      board.draw_pixel(col, row, {red: border_brightness, blue: 0, green: 0})
    end
  end

  Lodo::LIGHT_COLS.times do |col|
    [0,8].each do |row|
      board.draw_pixel(col, row, {red: border_brightness.to_i, blue: 0, green: 0})
    end
  end

  if border_brightness_increasing
    border_brightness += border_brightness_speed
  else
    border_brightness -= border_brightness_speed
  end

  if border_brightness >= 100
    border_brightness_increasing = false
    border_brightness = 100
  elsif border_brightness <= 0
    border_brightness_increasing = true
    border_brightness = 0
  end

  board.save
  offset -= 0.005
end
