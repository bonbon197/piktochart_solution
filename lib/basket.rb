require_relative 'product'
require_relative 'offer'
require_relative 'delivery_rule'

class Basket
  def initialize(products:, delivery_rule:, offers: [])
    @catalog = products.index_by(&:code)
    @delivery_rule = delivery_rule
    @offers = offers
    @items = []
  end

  def add(code)
    product = @catalog[code]
    raise "Invalid product code: #{code}" unless product
    @items << product
  end

  def total
    subtotal = @items.map(&:price).sum
    discount = @offers.sum { |offer| offer.apply(@items) }
    delivery = @delivery_rule.charge(subtotal - discount)
    total = subtotal - discount + delivery
    format("$%.2f", total)
  end
end