class LineItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :product, optional: true
  belongs_to :service, optional: true

  validate :must_be_product_or_service

  def must_be_product_or_service
    if product.blank? && service.blank?
      errors.add(:base, "A line item must be either a product or a service")
    elsif product.present? && service.present?
      errors.add(:base, "A line item can't be both a product and a service")
    end
  end
end
