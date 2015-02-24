# -*- encoding: utf-8 -*-

require File.expand_path("../lib/middleman-vcard/version", __FILE__)


Gem::Specification.new do |gem|
  gem.name          = "middleman-vcard"
  gem.version       = MiddlemanVCard::VERSION
  gem.summary       = %q{TODO: project summary}
  gem.description   = %q{TODO: project description}
  gem.license       = "Apache License Version 2.0"
  gem.authors       = ["Alessandro Molari"]
  gem.email         = "molari.alessandro@gmail.com"
  gem.homepage      = "https://rubygems.org/gems/middleman-vcard"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^spec/})
  gem.require_paths = ["lib"]

  gem.add_dependency("middleman-core", [">= 3.3.10"])
  gem.add_dependency("vpim")
  gem.add_dependency("contracts")

  gem.add_development_dependency("bundler")
  gem.add_development_dependency("rake")
  gem.add_development_dependency("yard")
  gem.add_development_dependency("rspec")
  gem.add_development_dependency("pry")
  gem.add_development_dependency("pry-byebug")

end
