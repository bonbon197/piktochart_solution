# README.md

## 🧾 Acme Widget Co – Checkout System (TDD Ruby)

This is a test-driven Ruby implementation of a pricing and checkout engine for Acme Widget Co. It models a shopping basket system that supports product cataloging, dynamic delivery fees, and promotional offers.

### ✅ Features
- Add products to a virtual basket using product codes
- Calculates total with delivery tiers
- Supports discount logic (Buy One Get One Half Off for Red Widgets)
- Written using TDD with RSpec

---

### 📦 Product Catalog
| Code | Name         | Price  |
|------|--------------|--------|
| R01  | Red Widget   | $32.95 |
| G01  | Green Widget | $24.95 |
| B01  | Blue Widget  | $7.95  |

---

### 🚚 Delivery Rules
| Subtotal         | Delivery Fee |
|------------------|---------------|
| $0 - $49.99      | $4.95         |
| $50 - $89.99     | $2.95         |
| $90 and above    | Free          |

---

### 🎁 Offers
- **Buy One Red Widget (R01), Get the Second at Half Price**

---

### 🛠 How to Run
```bash
# Install dependencies (RSpec)
gem install rspec

# Run the tests
rspec spec/basket_spec.rb

# Optionally run the demo
ruby main.rb
```

---

### 📁 Folder Structure
```
lib/
├── basket.rb
├── delivery_rule.rb
├── offer.rb
├── product.rb

spec/
└── basket_spec.rb

main.rb
README.md
```

---

### 🧪 TDD & Test Coverage
Implemented using RSpec with test coverage for:
- Expected baskets and totals
- Edge cases (empty baskets, floating point issues, invalid codes)
- Discounts and delivery thresholds

---

### 🧠 Design Decisions
- **Encapsulation**: Basket does not know implementation details of offers or delivery rules
- **Extensibility**: Offers follow the strategy pattern, allowing multiple or future rules
- **Dependency Injection**: All behavior injected at init for testability
- **Precision**: Prices rounded to 2 decimal places to avoid floating point drift

---

### 📌 Example Usage (in Ruby)
```ruby
basket = Basket.new(products: catalog, delivery_rule: rules, offers: [BuyOneGetHalfOff.new("R01")])
basket.add("R01")
basket.add("R01")
puts basket.total # => "$54.37"
```

---

### 🙋 Assumptions
- Product codes are case-sensitive
- Offers apply only to explicitly matching product codes
- Discount is applied before delivery is calculated

---

### 💬 Feedback
Happy to walk through design choices or extend this further during a technical interview. Let me know if you'd like to see multi-offer support, or basket state serialization!
