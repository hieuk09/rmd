# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rmd/version'

Gem::Specification.new do |spec|
  spec.name          = "rmd"
  spec.version       = Rmd::VERSION
  spec.authors       = ["Hieu Nguyen"]
  spec.email         = ["hieuk09@gmail.com"]
  spec.summary       = %q{RMD: Ruby Music Dowloader}
  spec.description   = %q{RMD: a music downloader written in pure ruby.}
  spec.homepage      = "https://github.com/hieuk09/rmd"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = 'rmd'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor', '~> 0.19'
  spec.add_dependency 'mechanize', '~> 2.7'
  spec.add_dependency 'ruby-progressbar', '~> 1.7'
  spec.add_dependency 'colorize', '~> 0.7'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rspec", '~> 3.1'
  spec.add_development_dependency "webmock", '~> 1.20'
  spec.add_development_dependency "vcr", '~> 2.9'
  spec.add_development_dependency "byebug", '~> 3.5'
end
