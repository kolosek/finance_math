# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = "finance_math"
  spec.version       = FinanceMath::VERSION
  spec.authors       = ["Nesha Zoric"]
  spec.email         = ["nesha@kolosek.com"]
  spec.summary       = %q{Most accurate APR and PMT caluclator for Ruby.}
  spec.description   = %q{Implementation of Loan/Mortgage functions in Ruby language. APR function and PMT function. In calculations it includes implementation of bank fee, marketplace fee, fees for each payment to provide the most precise calculation at very high speed. }
  spec.homepage      = "http://kolosek.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
end
