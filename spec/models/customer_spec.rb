require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items }
    it { should have_many(:items).through(:customer_items) }
  end

  describe 'instance methods' do
    it 'returns total price of items' do
      supermarket1 = Supermarket.create!(name: "Trader Joes", location: "DC")

      customer1 = Customer.create!(name: "Alex", supermarket_id: supermarket1.id)

      item1 = Item.create!(name: "Pretzels", price: 100)
      item2 = Item.create!(name: "Ice Cream", price: 50)
      item3 = Item.create!(name: "Salad", price: 10)

      customer_item1 = CustomerItem.create!(customer_id: customer1.id, item_id: item1.id)
      customer_item2 = CustomerItem.create!(customer_id: customer1.id, item_id: item2.id)
      customer_item3 = CustomerItem.create!(customer_id: customer1.id, item_id: item3.id)

      expect(customer1.total_price).to eq(160)
    end
  end
end