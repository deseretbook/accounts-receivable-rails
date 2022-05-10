# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

client = Client.create(name: "Acme inc", email: "ap@acme.com")

product_antivirus_software = Product.find_or_create_by(name: "Anti-virus software", price_cents: 200_00)
product_serverless_servers = Product.find_or_create_by(name: "Serverless servers", price_cents: 1000_00)

service_programming = Service.find_or_create_by(name: "Programming", price_cents: 80_00)
service_refactoring = Service.find_or_create_by(name: "Refactoring", price_cents: 350_00)

invoice_build = Invoice.find_or_create_by(client: client, net_days: 30, note: "Invoice for writing software for Acme")
invoice_refactor = Invoice.find_or_create_by(client: client, net_days: 30, note: "Invoice for refactoring software for Acme")

LineItem.find_or_create_by(invoice: invoice_build, service: service_programming, quantity: 40, description: "Amber's quality programming")
LineItem.find_or_create_by(invoice: invoice_build, service: service_programming, price_override_cents: 40_00, quantity: 40, description: "Justin's discount programming")
LineItem.find_or_create_by(invoice: invoice_build, product: product_serverless_servers, quantity: 20, description: "Enough serverless hardware to achieve web-scale")
LineItem.find_or_create_by(invoice: invoice_refactor, service: service_refactoring, quantity: 40, description: "Megan fixing previous discount programming")
LineItem.find_or_create_by(invoice: invoice_refactor, product: product_antivirus_software, quantity: 1, description: "Anti-virus software subscription")
