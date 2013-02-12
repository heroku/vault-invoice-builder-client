lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vault-invoice-builder-client/version'

Gem::Specification.new do |gem|
  gem.name          = "vault-invoice-builder-client"
  gem.version       = Vault::InvoiceBuilder::Client::VERSION
  gem.authors       = ["Chris Continanza", "Jamu Kakar", "Matthew Manning"]
  gem.email         = ["csquared@heroku.com", "jkakar@heroku.com",
                       "matthew@heroku.com"]
  gem.description   = "Client for Vault::InvoiceBuilder"
  gem.summary       = "A simple wrapper for the Vault::InvoiceBuilder HTTP API"
  gem.homepage      = "https://github.com/heroku/vault-invoice-builder-client"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep('^(test|spec|features)/')
  gem.require_paths = ["lib"]

  gem.add_dependency 'excon'
  gem.add_dependency 'yajl-ruby'
end
