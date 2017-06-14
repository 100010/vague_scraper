# coding: utf-8
require 'pry'
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)


require "vague_scraper/version"

Gem::Specification.new do |spec|
  spec.name          = "vague_scraper"
  spec.version       = VagueScraper::VERSION
  spec.authors       = ["Yohei Senju"]
  spec.email         = ["yohei.senju@gmail.com"]

  spec.summary       = %q{ Write a short summary, because Rubygems requires one.}
  spec.description   = %q{ Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/100010/vague_scraper"
  spec.license       = "MIT"


  spec.add_dependency "nokogiri"
  spec.add_dependency "httpclient"
  spec.add_dependency 'poltergeist'
  spec.add_dependency 'capybara'
  spec.add_dependency 'parallel'
  spec.add_dependency 'dotenv'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
end
