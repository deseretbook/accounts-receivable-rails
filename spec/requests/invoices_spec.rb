require "rails_helper"

RSpec.describe "Invoices", type: :request do
  let(:client_name) { "GotHub" }
  let(:service_name) { "Consulting Services" }
  let(:service) { create(:service, name: service_name) }
  let(:client) { create(:client, name: client_name) }
  let(:invoice) { create(:invoice, client: client, line_items: [build(:line_item, service: service)]) }

  describe "get /invoices" do
    subject { get invoices_path }

    it "renders index" do
      first_invoice =  create(:invoice, client: client, line_items: [build(:line_item, service: service)])
      second_invoice = create(:invoice, client: client, line_items: [build(:line_item, service: service)])

      subject

      expect(response).to render_template(:index)
      expect(response.body).to include(client_name)
      expect(response.body).to include(client_name)
    end
  end

  describe "get /invoices/:id" do
    subject { get invoice_path(invoice) }

    it "renders show" do
      subject

      expect(response).to render_template(:show)
      expect(response.body).to include(client_name)
      expect(response.body).to include(service_name)
    end
  end

  describe "get /invoices/new" do
    subject { get new_invoice_path }

    it "renders new" do
      subject
      expect(response).to render_template(:new)
    end
  end

  describe "post /invoices" do
    let(:invoice_name) { "Brand New Invoice" }

    subject { post invoices_path, params: {invoice: {name: invoice_name, client_id: client.id}} }

    it "creates a new invoice" do
      subject

      expect(response).to redirect_to(assigns(:invoice))
      follow_redirect!
      expect(response.body).to include("Invoice was successfully created.")
      expect(Invoice.count).to be(1)
    end
  end

  describe "put /invoices/:id" do
    let!(:new_client) { create :client }

    subject { put invoice_path(invoice), params: {invoice: {client_id: new_client.id}} }

    it "updates the invoice" do
      subject

      expect(response).to redirect_to(assigns(:invoice))
      follow_redirect!
      expect(response.body).to include("Invoice was successfully updated.")
      expect(invoice.reload.client_id).to be(new_client.id)
    end
  end

  describe "delete /invoices/:id" do
    subject { delete invoice_path(invoice) }

    it "destroys the invoice" do
      subject

      expect(response).to redirect_to(invoices_path)
      follow_redirect!
      expect(response.body).to include("Invoice was successfully destroyed.")
    end
  end
end
