# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openbd/version'

Gem::Specification.new do |spec|
  spec.name          = "openbd_api"
  spec.version       = Openbd::VERSION
  spec.authors       = ["nasum"]
  spec.email         = ["tomato.wonder.life@gmail.com"]

  spec.summary       = %q{This gem wraps openBD Web API.}
  spec.description   = %q{This gem wraps openBD Web API.}
  spec.homepage      = "https://github.com/nasum/openbd"
  spec.license       = "MIT"

  spec.required_ruby_version = '~> 2.2'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency "slop", "~> 4.4"
end
