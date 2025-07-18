class Offer
  def apply(products)
    raise NotImplementedError, "Offers must implement #apply"
  end
end

class BuyOneGetHalfOff < Offer
  def initialize(code)
    @code = code
  end

  def apply(products)
    matched = products.select { |p| p.code == @code }
    return 0.0 if matched.empty?
    
    count = matched.size / 2
    discount = (matched.first.price / 2.0) * count
    discount.round(2)
  end
end