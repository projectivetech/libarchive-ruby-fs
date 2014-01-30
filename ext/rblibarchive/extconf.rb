require 'mkmf'

unless (libarchive_cfg = pkg_config('libarchive'))
  abort 'Failed to locate pkg-config file for libarchive.'
end

unless have_library('archive')
  abort 'Failed to test-link against libarchive.'
end

non_std_location = libarchive_cfg.detect { |flag| flag =~ /^-L/ }
if non_std_location
  non_std_location.gsub!('-L', '')
  $LDFLAGS << " -Wl,-rpath,#{non_std_location}"
  message "embedding path to library into rblibarchive.so: #{non_std_location}\n"
end

with_cppflags("#{(libarchive_cfg.detect { |flag| flag =~ /^-I/ })}") do
  create_makefile('rblibarchive')
end
