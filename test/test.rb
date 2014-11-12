# encoding: UTF-8

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

class UnicodeTest < MiniTest::Test
  {
    # Some unicode string in utf-8 within script.
    "٩(-̮̮̃-̃)۶٩(●̮̮̃•̃)۶٩(͡๏̯͡๏)۶٩(-̮̮̃•̃)äöü." => 'in_script',
    # 'xäx' in UTF-8.
    [120, 195, 164, 120].pack('C*').force_encoding('UTF-8') => 'simple',
    # 'xäx' in UTF-8 with a" combining characters.
    [120, 97, 204, 136, 120].pack('C*').force_encoding('UTF-8') => 'combining'
  }.each do |file, tname|
    define_method("test_unicode_zip_#{tname}") do
      begin
        LibArchiveRubyFs.write_open_filename('unicode.zip', LibArchiveRubyFs::COMPRESSION_COMPRESS, LibArchiveRubyFs::FORMAT_ZIP) do |ball|
          ball.new_entry do |entry|
            entry.copy_stat(__FILE__)
            entry.pathname = file
            ball.write_header(entry)
          end
        end

        LibArchiveRubyFs.read_open_filename('unicode.zip', LibArchiveRubyFs::COMPRESSION_COMPRESS, LibArchiveRubyFs::FORMAT_ZIP) do |ball|
          entry = ball.next_header
          assert_equal(entry.pathname, file)
        end
      ensure
        FileUtils.rm_f('unicode.zip')
      end
    end

    define_method("test_unicode_tar_#{tname}") do
      begin
        LibArchiveRubyFs.write_open_filename('unicode.tar', LibArchiveRubyFs::COMPRESSION_NONE, LibArchiveRubyFs::FORMAT_TAR) do |ball|
          ball.new_entry do |entry|
            entry.copy_stat(__FILE__)
            entry.pathname = file
            ball.write_header(entry)
            ball.write_data(File.read(__FILE__))
          end
        end

        LibArchiveRubyFs.read_open_filename('unicode.tar', LibArchiveRubyFs::COMPRESSION_NONE, LibArchiveRubyFs::FORMAT_TAR) do |ball|
          entry = ball.next_header
          assert_equal(entry.pathname, file)
        end
      ensure
        FileUtils.rm('unicode.tar')
      end
    end
  end
end
