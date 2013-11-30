task :build_ext do
  `gcc -c -fPIC tclled.c -o tclled.o`
  `gcc -shared -Wl,-soname,libtclled.so.1 -o libtclled.so.1.0.1  tclled.o`
end