module InvoicesHelper
  def to_money(cents)
    return "$0.00" if cents == 0
    "$#{cents.to_s.insert(-3, ".")}"
  end
end
