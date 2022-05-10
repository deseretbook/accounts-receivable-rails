require "rails_helper"

RSpec.describe "Services", type: :request do
  let!(:first_service) { create :service }
  let!(:second_service) { create :service }

  describe "get /services" do
    subject { get services_path }

    it "renders index" do
      subject

      expect(response).to render_template(:index)
      expect(response.body).to include(first_service.name)
      expect(response.body).to include(second_service.name)
    end
  end

  describe "get /products/new" do
    subject { get new_service_path }

    it "renders new" do
      subject
      expect(response).to render_template(:new)
    end
  end

  describe "post /services" do
    let(:new_service) { build :service }

    subject { post services_path, params: {service: {name: new_service.name, price_cents: new_service.price_cents}} }

    it "creates a new service" do
      subject

      expect(response).to redirect_to(assigns(:service))
      follow_redirect!
      expect(response.body).to include("Service was successfully created.")
    end
  end

  describe "put /service/:id" do
    subject { put service_path(first_service), params: {service: {price_cents: 100}} }

    it "updates the service" do
      subject

      expect(response).to redirect_to(assigns(:service))
      follow_redirect!
      expect(response.body).to include("Service was successfully updated.")
    end
  end

  describe "delete /services/:id" do
    subject { delete service_path(first_service) }

    it "destroys the service" do
      subject

      expect(response).to redirect_to(services_path)
      follow_redirect!
      expect(response.body).to include("Service was successfully destroyed.")
    end
  end
end
