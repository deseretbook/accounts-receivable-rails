require "rails_helper"

RSpec.describe "Line Items", type: :request do
  let!(:service) { create :service }
  let!(:line_item) { create :line_item, invoice: invoice, service: service}
  let!(:invoice) { create :invoice }

  describe "get /line_items" do
    subject { get line_items_path }

    it "renders index" do
      subject

      expect(response).to render_template(:index)
      expect(response.body).to include(line_item.service.name)
    end
  end

  describe "get /line_items/new" do
    subject { get new_line_item_path }

    it "renders new" do
      subject
      expect(response).to render_template(:new)
    end
  end

  describe "post /line_items" do
    let!(:product) { create :product }

    subject { post line_items_path, params: {line_item: {invoice_id: invoice.id, product_id: product.id, quantity: 1}} }

    it "creates a new line item" do
      subject

      expect(response).to redirect_to(assigns(:line_item))
      follow_redirect!
      expect(response.body).to include("Line item was successfully created.")
    end
  end

  describe "put /line_item/:id" do
    let!(:new_service) { create :service }

    subject { put line_item_path(line_item), params: {line_item: {service_id: new_service.id}} }

    it "updates the line item" do
      subject

      expect(response).to redirect_to(assigns(:line_item))
      follow_redirect!
      expect(response.body).to include("Line item was successfully updated.")
    end
  end

  describe "delete /line_items/:id" do
    subject { delete line_item_path(line_item) }

    it "destroys the line item" do
      subject

      expect(response).to redirect_to(line_items_path)
      follow_redirect!
      expect(response.body).to include("Line item was successfully destroyed.")
    end
  end
end
