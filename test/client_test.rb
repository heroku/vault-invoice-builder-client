require 'helper'

class ClientTest < Vault::TestCase
  include Vault::Test::EnvironmentHelpers

  def setup
    super
    Excon.stubs.clear
    Excon.defaults[:mock] = true
    @client = Vault::InvoiceBuilder::Client.new(
      'https://vault-invoice-builder.herokuapp.com')
    @receipt = {user: 'user123@heroku.com',
                start_time: Time.utc(2012, 1),
                stop_time: Time.utc(2012, 2)}
  end

  def teardown
    # FIXME This is a bit ugly, but Excon doesn't provide a builtin way to
    # ensure that a request was invoked, so we have to do it ourselves.
    # Without this, and the Excon.stubs.pop calls in the tests below, tests
    # will pass if request logic is completely removed from application
    # code. -jkakar
    assert(Excon.stubs.empty?, 'Expected HTTP requests were not made.')
    super
  end

  # Client.new looks for VAULT_INVOICE_BUILDER_URL if none is passed to the
  # constructor.
  def test_uses_url_from_environment_by_default
    url = 'http://example.com'
    set_env 'VAULT_INVOICE_BUILDER_URL', url
    @client = Vault::InvoiceBuilder::Client.new
    assert_equal(url, @client.url)
  end

  # Client.render_html makes a PUT request to the Vault::InvoiceBuilder HTTP
  # API, passing the supplied credentials using HTTP basic auth, to report
  # that usage of a product began at a particular time.
  def test_render_html
    content = '<html><body><p>Hello, world!</p></body></html>'
    Excon.stub(method: :post) do |request|
      assert_equal('vault-invoice-builder.herokuapp.com:443',
                   request[:host_port])
      assert_equal("/invoice.html", request[:path])
      Excon.stubs.pop
      {status: 200, body: content}
    end
    assert_equal(content, @client.render_html(@receipt))
  end

  # Client.render_html raises the appropriate Excon::Errors::HTTPStatusError
  # if an unsuccessful HTTP status code is returned by the server.
  def test_render_html_with_unsuccessful_response
    Excon.stub(method: :post) do |request|
      Excon.stubs.pop
      {status: 400, body: 'Bad inputs provided.'}
    end
    assert_raises Excon::Errors::BadRequest do
      @client.render_html(@receipt)
    end
  end
end
