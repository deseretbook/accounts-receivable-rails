require "rails_helper"

RSpec.describe "Products", type: :request do
  let!(:first_product) { create :product }
  let!(:second_product) { create :product }

  describe "get /products" do
    subject { get products_path }

    it "renders index" do
      subject

      expect(response).to render_template(:index)
      expect(response.body).to include(first_product.name)
      expect(response.body).to include(second_product.name)
    end
  end

  describe "get /products/new" do
    subject { get new_product_path }

    it "renders new" do
      subject
      expect(response).to render_template(:new)
    end
  end

  describe "post /products" do
    let(:new_product) { build :product }

    subject { post products_path, params: {product: {name: new_product.name, price_cents: new_product.price_cents}} }

    it "creates a new product" do
      subject

      expect(response).to redirect_to(assigns(:product))
      follow_redirect!
      expect(response.body).to include("Product was successfully created.")
    end
  end

  describe "put /product/:id" do
    subject { put product_path(first_product), params: {product: {price_cents: 100}} }

    it "updates the product" do
      subject

      expect(response).to redirect_to(assigns(:product))
      follow_redirect!
      expect(response.body).to include("Product was successfully updated.")
    end
  end

  describe "delete /products/:id" do
    subject { delete product_path(first_product) }

    it "destroys the product" do
      subject

      expect(response).to redirect_to(products_path)
      follow_redirect!
      expect(response.body).to include("Product was successfully destroyed.")
    end
  end
end
