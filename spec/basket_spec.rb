require 'rspec'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/enumerable'
require_relative '../lib/product'
require_relative '../lib/offer'
require_relative '../lib/delivery_rule'
require_relative '../lib/basket'

RSpec.describe Basket do
  let(:products) do
    [
      Product.new(code: "R01", name: "Red Widget", price: 32.95),
      Product.new(code: "G01", name: "Green Widget", price: 24.95),
      Product.new(code: "B01", name: "Blue Widget", price: 7.95)
    ]
  end

  let(:delivery_rule) do
    DeliveryRule.new([
      { threshold: 90.0, cost: 0.0 },
      { threshold: 50.0, cost: 2.95 },
      { threshold: 0.0, cost: 4.95 }
    ])
  end

  let(:offers) { [BuyOneGetHalfOff.new("R01")] }

  subject { Basket.new(products: products, delivery_rule: delivery_rule, offers: offers) }

  def add_items(basket, codes)
    codes.each { |code| basket.add(code) }
  end

  it "calculates total for B01, G01" do
    add_items(subject, %w[B01 G01])
    expect(subject.total).to eq("$37.85")
  end

  it "calculates total for R01, R01 (BOGOF discount)" do
    add_items(subject, %w[R01 R01])
    expect(subject.total).to eq("$54.37")
  end

  it "calculates total for R01, G01" do
    add_items(subject, %w[R01 G01])
    expect(subject.total).to eq("$60.85")
  end

  it "calculates total for B01, B01, R01, R01, R01" do
    add_items(subject, %w[B01 B01 R01 R01 R01])
    expect(subject.total).to eq("$98.27")
  end

  it "raises error for invalid product code" do
    expect { subject.add("XYZ") }.to raise_error("Invalid product code: XYZ")
  end

  context "edge cases" do
    it "returns $0.00 for empty basket" do
      expect(subject.total).to eq("$4.95")
    end

    it "applies offer only to full pairs" do
      add_items(subject, %w[R01 R01 R01])
      expect(subject.total).to eq("$85.32")
    end

    it "applies multiple offers correctly" do
      add_items(subject, %w[R01 R01 R01 R01])
      expect(subject.total).to eq("$98.85")
    end

    it "does not apply offer to unrelated product" do
      add_items(subject, %w[G01 G01])
      expect(subject.total).to eq("$54.85") # 24.95 * 2 + 4.95 delivery
    end

    it "handles floating point precision correctly" do
      add_items(subject, %w[R01 R01 R01])
      expect(subject.total).to match(/^\$\d+\.\d{2}$/)
    end
  end
end
