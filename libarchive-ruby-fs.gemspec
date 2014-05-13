$:.unshift(File.expand_path('../lib', __FILE__))
require 'libarchive-ruby-fs/version'

Gem::Specification.new do |spec|
  spec.name              = 'libarchive-ruby-fs'
  spec.version           = LibArchiveRubyFs::VERSION
  spec.summary           = 'Ruby bindings for Libarchive.'
  spec.description       = 'Ruby bindings for Libarchive. Libarchive is a programming library that can create and read several different streaming archive formats, including most popular tar variants, several cpio formats, and both BSD and GNU ar variants.'
  
  spec.authors           = ['winebarrel', 'FlavourSys Technology GmbH']
  spec.email             = 'technology@flavoursys.com'
  spec.homepage          = 'http://libarchive.rubyforge.org'

  spec.files             = Dir.glob('ext/**/*') + Dir.glob('lib/**/*.rb')
  spec.extensions        = ['ext/rblibarchive/extconf.rb']
  spec.require_paths     = ['lib']

  spec.add_development_dependency 'rake-compiler', '~> 0.9'
  spec.add_development_dependency 'minitest', '~> 5.3'
end
