class CurrencyConverter
  class ConversionNotFoundError < StandardError; end
  attr_accessor :from, :to, :cents

  def initialize(from:, to:, cents:)
    Money.add_rate('USD', 'JPY', 130.44)
    Money.add_rate('JPY', 'USD', 0.0077)

    @from = from.to_s.upcase
    @to = to.to_s.upcase
    @cents = cents.to_i
  end

  def self.convert(from:, to:, cents:)
    new(from: from, to: to, cents: cents).convert
  end

  def convert
    Money.from_cents(cents, from).exchange_to(to).to_i
  rescue Money::Currency::UnknownCurrency => e
    raise ConversionNotFoundError.new(e)
  end
end
