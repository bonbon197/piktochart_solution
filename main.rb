require_relative 'lib/product'
require_relative 'lib/offer'

products = [
    Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
    Product.new(code: 'B01', name: 'Blue Widget', price: 7.95),
    Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
]

offers = [BuyOneGetHalfOff.new("R01")]


delivery_rule = DeliveryRule.new([
  { threshold: 90.0, cost: 0.0 },
  { threshold: 50.0, cost: 2.95 },
  { threshold: 0.0, cost: 4.95 }
])