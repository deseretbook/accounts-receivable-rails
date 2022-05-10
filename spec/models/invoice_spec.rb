require "rails_helper"

RSpec.describe Invoice, type: :model do
  let(:client) { create :client }
  let(:invoice) { create :invoice, client: }

  describe "associated record" do
    subject { invoice }

    it "has a client association" do
      expect(subject.client_id).to eq(client.id)
    end
  end
end
