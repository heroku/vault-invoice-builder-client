module Vault::InvoiceBuilder
  # Client for the `Vault::InvoiceBuilder` HTTP API.
  class Client
    # The `Vault::InvoiceBuilder` HTTP API URL.
    attr_reader :url

    # Instantiate a client.
    #
    # @param url [String] The URL to connect to.  Include the username and
    #   password to use when connecting.  Defaults to the URL defined in the
    #   `VAULT_INVOICE_BUILDER_URL` environment variable if one isn't
    #   explicitly provided.
    def initialize(url = nil)
      @url = url || ENV['VAULT_INVOICE_BUILDER_URL']
    end

    # Render a receipt into an HTML invoice.
    #
    # @param receipt [Hash] An object matching the receipt format described in
    #   the `Vault::InvoiceBuilder` README.
    # @raise [Excon::Errors::HTTPStatusError] Raised if the server returns an
    #   unsuccessful HTTP status code.
    # @return [String] The rendered HTML invoice.
    def render_html(receipt)
      connection = Excon.new(@url)
      response = connection.post(
        path: "/invoice.html",
        headers: {'Content-Type' => 'application/json'},
        body: JSON.generate(receipt),
        expects: [200])
      response.body
    end

    # Render a receipt into an HTML invoice and store it to S3.
    #
    # @param receipt [Hash] An object matching the receipt format described in
    #   the `Vault::InvoiceBuilder` README.
    # @raise [Excon::Errors::HTTPStatusError] Raised if the server returns an
    #   unsuccessful HTTP status code.
    # @return [Excon::Response] The response object.
    def store(receipt)
      connection = Excon.new(@url)
      response = connection.post(
        path: '/store',
        headers: {'Content-Type' => 'application/json'},
        body: JSON.generate(receipt),
        expects: [200])
    end
  end
end
