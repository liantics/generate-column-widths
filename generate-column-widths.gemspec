# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'generate-column-widths/version'

Gem::Specification.new do |spec|
  spec.name          = "generate-column-widths"
  spec.version       = Generate::Column::Widths::VERSION
  spec.authors       = ["'Liane Allen'"]
  spec.email         = ["'github@lianeallen.com'"]
  spec.summary       = %q{Generate the span value to use with a css grid system.}
  spec.description   = %q{Automatically generates the span value to use when
                          your view may have a variable number of columns,
                          and you're using a css grid system.}
  spec.homepage      = "http://github.com/liantics/generate-column-widths"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
