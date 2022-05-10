require "rails_helper"

RSpec.describe LineItem, type: :model do
  let(:client) { create :client }
  let(:line_item_kwargs) { {} }
  let(:invoice) { create :invoice, client: client }
  let(:line_item) { build :line_item, invoice: invoice, **line_item_kwargs }

  describe "must_be_product_or_service" do
    subject { line_item }

    context "product and service are blank" do
      it "raises an error" do
        expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: A line item must be either a product or a service")
      end
    end

    context "product and service are present" do
      let(:product) { create(:product) }
      let(:service) { create(:service) }
      let(:line_item_kwargs) { {product: product, service: service} }

      it "raises an error" do
        expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: A line item can't be both a product and a service")
      end
    end

    context "product is present" do
      let(:product) { create :product }
      let(:line_item_kwargs) { {product: product} }

      it "is valid to have a product line_item" do
        expect(subject.product).to eq(product)
      end
    end

    context "service is present" do
      let(:service) { create :service }
      let(:line_item_kwargs) { {service: service} }

      it "is valid to have a service line_item" do
        expect(subject.service).to eq(service)
      end
    end
  end
end
