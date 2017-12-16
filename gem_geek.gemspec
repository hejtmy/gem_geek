# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gem_geek/version'

Gem::Specification.new do |spec|
  spec.name          = "gem_geek"
  spec.version       = GemGeek::VERSION
  spec.authors       = ["Luk\xC3\xA1\xC5\xA1 Hejtm\xC3\xA1nek"]
  spec.email         = ["hejtmy@gmail.com"]

  spec.summary       = "Ruby gem that allows manipulation with boardgamegeek.com data"
  spec.description   = "Gem provides simple interface that donwloads various bgg data, parses returned contents and serves ruby objects. As additional functionality, gem also computes some simple play and collection statistics"
  spec.homepage      = ""

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency "oj", "~> 3.0.0"
  spec.add_runtime_dependency "nokogiri"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
