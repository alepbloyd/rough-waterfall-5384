require 'rails_helper'

RSpec.describe Supermarket, type: :model do
  describe 'relationships' do
    it { should have_many :customers }
    it { should have_many(:customer_items).through(:customers)}
    it { should have_many(:items).through(:customer_items)}
  end

  describe 'instance methods' do
    it 'returns list of unique items' do
      supermarket1 = Supermarket.create!(name: "Trader Joes", location: "DC")

      customer1 = Customer.create!(name: "Alex", supermarket_id: supermarket1.id)

      item1 = Item.create!(name: "Pretzels", price: 100)
      item2 = Item.create!(name: "Ice Cream", price: 50)
      item3 = Item.create!(name: "Salad", price: 10)
      item4 = Item.create!(name: "Chips", price: 5)
      item5 = Item.create!(name: "Chips", price: 5)

      customer_item1 = CustomerItem.create!(customer_id: customer1.id, item_id: item1.id)
      customer_item2 = CustomerItem.create!(customer_id: customer1.id, item_id: item2.id)
      customer_item3 = CustomerItem.create!(customer_id: customer1.id, item_id: item3.id)
      customer_item4 = CustomerItem.create!(customer_id: customer1.id, item_id: item4.id)
      customer_item5 = CustomerItem.create!(customer_id: customer1.id, item_id: item5.id)

      expect(supermarket1.unique_item_names).to eq(["Pretzels","Ice Cream","Salad","Chips"])

    end
  end
end