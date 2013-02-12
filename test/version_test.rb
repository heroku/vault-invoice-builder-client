require 'helper'

class VersionTest < Vault::TestCase
  # Vault::InvoiceBuilder::Client::VERSION is a string matching the
  # `major.minor.patch` format.
  def test_version
    assert_match(/\d+\.\d+\.\d+/, Vault::InvoiceBuilder::Client::VERSION)
  end
end
