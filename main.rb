require_relative 'lib/product'
require_relative 'lib/offer'

products = [
    Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
    Product.new(code: 'B01', name: 'Blue Widget', price: 7.95),
    Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
]

offers = [BuyOneGetHalfOff.new("R01")]