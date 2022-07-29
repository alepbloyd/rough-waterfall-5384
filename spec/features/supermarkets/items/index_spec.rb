require 'rails_helper'

RSpec.describe 'supermarket items index page' do
  
  it 'has list of all unique items at given supermarket' do
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

    visit "/supermarkets/#{supermarket1.id}/items"

    within "#supermarket-items" do
      expect(page).to have_content("Pretzels")
      expect(page).to have_content("Ice Cream")
      expect(page).to have_content("Salad")
      expect(page).to have_content("Chips")
    end
  end

end