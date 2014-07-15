lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "scheman/rails/version"

Gem::Specification.new do |spec|
  spec.name          = "scheman-rails"
  spec.version       = Scheman::Rails::VERSION
  spec.authors       = ["Ryo Nakamura"]
  spec.email         = ["r7kamura@gmail.com"]
  spec.summary       = "Rails plugin for Scheman."
  spec.homepage      = "https://github.com/r7kamura/scheman-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 3.0.0"
  spec.add_dependency "scheman", ">= 0.0.4"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "mysql2"
  spec.add_development_dependency "rails", "4.1.4"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "2.14.1"
  spec.add_development_dependency "rspec-rails", "2.14.1"
end
