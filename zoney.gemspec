
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "zoney/version"

Gem::Specification.new do |spec|
  spec.name          = "zoney"
  spec.version       = Zoney::VERSION
  spec.authors       = ["Justin Kenyon"]
  spec.email         = ["kenyonj@gmail.com"]

  spec.summary       = "Wrapper for interacting with the MonoPrice 6 Zone Amplifier."
  spec.description   = "This provides an api for interacting with the MonoPrice 6 Zone Amplifier via a serial port connection. You can control up to 3 linked amplifiers."
  spec.homepage      = "https://www.github.com/kenyonj/zoney"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubyserial", "~> 0.5.0"
  spec.add_development_dependency "pry-rails"
end
