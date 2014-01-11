desc "Build C extensions"
task :build_ext do
  `gcc -c -fPIC tclled.c -o tclled.o`
  `gcc -shared -Wl,-soname,libtclled.so.1 -o libtclled.so.1.0.1  tclled.o`
end

desc "Configure the SPI. Must be run after every boot."
task :setup_spi do
  `echo BB-SPI0-01 > /sys/devices/bone_capemgr.8/slots`

  # Setup pins for analog in
  `echo cape-bone-iio > /sys/devices/bone_capemgr.8/slots`

  # Setup the pins for outputting the address
  #
  # Port Pin Kernal
  # 8    15  23
  # 8    17  47
  # 8    19  27
  # 8    21  22

  `echo 23 > /sys/class/gpio/export`
  `echo 47 > /sys/class/gpio/export`
  `echo 27 > /sys/class/gpio/export`
  `echo 22 > /sys/class/gpio/export`

  # Set the pins to digital output
  `echo out > /sys/class/gpio/gpio23/direction`
  `echo out > /sys/class/gpio/gpio47/direction`
  `echo out > /sys/class/gpio/gpio27/direction`
  `echo out > /sys/class/gpio/gpio22/direction`

  # Now set the pins to digital zero
  `echo 0 > /sys/class/gpio/gpio23/value`
  `echo 0 > /sys/class/gpio/gpio47/value`
  `echo 0 > /sys/class/gpio/gpio27/value`
  `echo 0 > /sys/class/gpio/gpio22/value`
end

task :setup => [:build_ext, :setup_spi]