# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openbd/version'

Gem::Specification.new do |spec|
  spec.name          = "openbd_api"
  spec.version       = Openbd::VERSION
  spec.authors       = ["nasum"]
  spec.email         = ["tomato.wonder.life@gmail.com"]

  spec.summary       = %q{openBD API written by Ruby.}
  spec.description   = %q{openBD API written by Ruby.}
  spec.homepage      = "https://github.com/nasum/openbd"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
