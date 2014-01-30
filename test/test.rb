# Acceptance tests :-)

require 'digest/md5'
require 'fileutils'
require 'minitest'
require 'minitest/autorun'
require 'libarchive-ruby-fs'

def digest
  md5 = Digest::MD5.new
  md5.update(File.read(__FILE__))
  md5.digest
end

def tar
  LibArchiveRubyFs.write_open_filename("#{__FILE__}.tar", LibArchiveRubyFs::COMPRESSION_NONE, LibArchiveRubyFs::FORMAT_TAR) do |ball|
    ball.new_entry do |entry|
      entry.copy_stat(__FILE__)
      entry.pathname = __FILE__
      ball.write_header(entry)
      ball.write_data(File.read(__FILE__))
    end
  end
end

def untar
  LibArchiveRubyFs.read_open_filename("#{__FILE__}.tar", LibArchiveRubyFs::COMPRESSION_NONE, LibArchiveRubyFs::FORMAT_TAR) do |ball|
    entry = ball.next_header
    File.open(entry.pathname, 'w') do |fd|
      ball.read_data { |chunk| fd.write(chunk) }
    end
  end
  FileUtils.rm("#{__FILE__}.tar")
end

class TarTest < MiniTest::Test
  def test_tar_untar
    digest_before = digest
    tar
    untar
    assert_equal(digest_before, digest)
  end
end
