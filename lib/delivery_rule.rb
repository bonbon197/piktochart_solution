class DeliveryRule
  def initialize(rules)
    @rules = rules.sort_by { |r| r[:threshold] }
  end

  def charge(subtotal)
    @rules.reverse.find { |r| subtotal >= r[:threshold] }[:cost]
  end
end
