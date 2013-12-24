require './lib/lodo'

lights = Lodo::String.new
lights.reset

brightness = 0
going_up = true
colors = [
  {r: 1, g: 0, b: 0},
  {r: 0, g: 1, b: 0},
  {r: 0, g: 0, b: 1},
  {r: 0, g: 1, b: 1},
  {r: 1, g: 0, b: 1},
  {r: 0.5, g: 0, b: 1},
  {r: 1, g: 1, b: 0},
  {r: 1, g: 1, b: 1}
]
color = colors.sample

loop do
  (Lodo::String::LED_COUNT - 1).downto(0) do |light_number|
    if light_number == 0
      lights[light_number] = {red: brightness.abs * color[:r], green: brightness.abs * color[:g], blue: brightness.abs * color[:b]}
    else
      lights[light_number] = lights[light_number - 1]
    end
  end

  lights.save

  if going_up
    brightness += 10
    if brightness > 255
      going_up = false
      brightness = 255
    end
  else
    brightness -= 10
    if brightness < 0
      going_up = true
      brightness = 0
      color = colors.sample
    end
  end

  sleep 0.03
end
