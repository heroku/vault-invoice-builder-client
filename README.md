# Vault::InvoiceBuilder::Client

A Ruby client for the `Vault::InvoiceBuilder` HTTP API.

## Setting up a development environment

Install dependencies and run the test suite:

    bundle install --binstubs vendor/bin
    rbenv rehash
    rake

Run tests:

    rake test

See tasks:

    rake -T

Generate API documentation:

    rake yard

## Using the client

The `Vault::InvoiceBuilder` API may only be accessed anonymously:

```ruby
require 'vault-invoice-builder-client'

client = Vault::InvoiceBuilder::Client.new(
  'https://vault-invoice-builder.herokuapp.com')
```

### Rendering an invoice.

An invoice contains customer contact and tax details, a list of apps
and the charges they've incurred by consuming dyno hours and using
addons, a list of charges for products the customer used directly,
such as a support contract, and credits that have been applied to
cover some or all of the charges on the invoice.  An invoice is
rendered from a receipt, a JSON representation of app and user charges
and credits.

```ruby
receipt = {user: 'user123@heroku.com', start_time: …, …}
html_content = client.render_html(receipt)
```
