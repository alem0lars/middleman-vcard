# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)
require "middleman-vcard/version"


Gem::Specification.new do |s|
  s.name    = "middleman-vcard"
  s.version = Middleman::VCard::VERSION
  s.license = "Apache License Version 2.0"

  s.authors     = ["Alessandro Molari"]
  s.email       = "molari.alessandro@gmail.com"
  s.homepage    = "https://github.com/alem0lars/middleman-vcard"
  s.summary     = %q{Middleman extension to generate VCards}
  s.description = %q{
    A Middleman extension to automatically generate VCards based on provided
    configurations. It also includes some useful Middleman helpers to work with
    the generated VCards. This is particularly useful in contacts pages to
    create a vcard button.
  }

  s.required_ruby_version = ">= 1.9.3"
  s.platform              = Gem::Platform::RUBY

  s.files       = `git ls-files -z`.split("\0")
  s.executables = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files  = s.files.grep(%r{^spec/})

  s.require_paths = ["lib"]

  s.add_dependency("middleman-core", [">= 3.3.10"])
  s.add_dependency("vpim")
  s.add_dependency("contracts")

  s.add_development_dependency("bundler")
  s.add_development_dependency("rake")
  s.add_development_dependency("yard")
  s.add_development_dependency("rspec")
  s.add_development_dependency("pry")

end
