$:.unshift File.expand_path('../lib', __FILE__)

require "rubygems"
require "grove/version"

Gem::Specification.new do |gem|
  gem.name          = "grove-rb"
  gem.version       = Grove::VERSION
  gem.author        = "Bryan Goines"
  gem.summary       = "Grove.io client for Ruby"
  gem.email         = "bryann83@gmail.com"
  gem.homepage      = "http://github.com/bry4n/grove-rb"
  gem.files = Dir['**/*']
  # gem.executables = ""
  gem.add_dependency "faraday", "~> 0.7.6"
end
