task :build_ext do
  `gcc -c -fPIC tclled.c -o tclled.o`
  `gcc -shared -Wl,-soname,libtclled.so.1 -o libtclled.so.1.0.1  tclled.o`
end

task :setup_spi do
  `echo -5 > /sys/devices/bone_capemgr.8/slots`
  `echo -6 > /sys/devices/bone_capemgr.8/slots`
  `echo BB-SPI1-01 > /sys/devices/bone_capemgr.8/slots`
end