require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require 'excon'
require 'yajl/json_gem'

module Vault
  module InvoiceBuilder
    # Client provides a Ruby API to access the `Vault::InvoiceBuilder` HTTP
    # API.
    class Client
    end
  end
end

require 'vault-invoice-builder-client/client'
require 'vault-invoice-builder-client/version'
