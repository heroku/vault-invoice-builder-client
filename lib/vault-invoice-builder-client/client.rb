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

    # Render a statement into an HTML invoice.
    #
    # @param statement [Hash] An object matching the statement format described in
    #   the `Vault::InvoiceBuilder` README.
    # @raise [Excon::Errors::HTTPStatusError] Raised if the server returns an
    #   unsuccessful HTTP status code.
    # @return [String] The rendered HTML invoice.
    def render_html(statement)
      connection = Excon.new(@url)
      response = connection.post(
        path: "/invoice.html",
        headers: {'Content-Type' => 'application/json'},
        body: JSON.generate(statement),
        expects: [200])
      response.body
    end

    # POST a statement to to the proxy-able /statement/:id endpoint
    #
    # @param statement [Hash] An object matching the statement format described in
    #   the `Vault::InvoiceBuilder` README.
    # @raise [Excon::Errors::HTTPStatusError] Raised if the server returns an
    #   unsuccessful HTTP status code.
    # @return [Excon::Response] The response object.
    def post(statement)
      connection = Excon.new(@url)
      id = statement[:id] || statement['id']
      response = connection.post(
        path: "/statement/#{id}",
        headers: {'Content-Type' => 'application/json'},
        body: JSON.generate(statement),
        expects: [200])
    end

    # @deprecated
    #
    # @param statement [Hash] An object matching the statement format described in
    #   the `Vault::InvoiceBuilder` README.
    # @raise [Excon::Errors::HTTPStatusError] Raised if the server returns an
    #   unsuccessful HTTP status code.
    # @return [Excon::Response] The response object.
    def store(statement)
      connection = Excon.new(@url)
      response = connection.post(
        path: '/store',
        headers: {'Content-Type' => 'application/json'},
        body: JSON.generate(statement),
        expects: [200])
    end
  end
end
