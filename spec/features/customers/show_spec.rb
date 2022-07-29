require 'rails_helper'

RSpec.describe 'customer show page' do

  it 'shows list of customer\'s items' do
    supermarket1 = Supermarket.create!(name: "Trader Joes", location: "DC")

    customer1 = Customer.create!(name: "Alex", supermarket_id: supermarket1.id)
    customer2 = Customer.create!(name: "Kiara", supermarket_id: supermarket1.id)

    item1 = Item.create!(name: "Pretzels", price: 100)
    item2 = Item.create!(name: "Ice Cream", price: 50)
    item3 = Item.create!(name: "Salad", price: 10)
    item4 = Item.create!(name: "Chips", price: 5)

    customer_item1 = CustomerItem.create!(customer_id: customer1.id, item_id: item1.id)
    customer_item2 = CustomerItem.create!(customer_id: customer1.id, item_id: item2.id)
    customer_item3 = CustomerItem.create!(customer_id: customer1.id, item_id: item3.id)

    visit "/customers/#{customer1.id}"

    within "#item-#{item1.id}" do
      expect(page).to have_content("Item Name: #{item1.name}")
      expect(page).to have_content("Item Price: #{item1.price}")
    end

    within "#item-#{item2.id}" do
      expect(page).to have_content("Item Name: #{item2.name}")
      expect(page).to have_content("Item Price: #{item2.price}")
    end

    within "#item-#{item3.id}" do
      expect(page).to have_content("Item Name: #{item3.name}")
      expect(page).to have_content("Item Price: #{item3.price}")
    end

    expect(page).to_not have_content("Chips")
  end

  it 'displays name of supermarket customer belongs to' do
    supermarket1 = Supermarket.create!(name: "Trader Joes", location: "DC")
    supermarket2 = Supermarket.create!(name: "Whole Foods", location: "New York")

    customer1 = Customer.create!(name: "Alex", supermarket_id: supermarket1.id)
    customer2 = Customer.create!(name: "Kiara", supermarket_id: supermarket1.id)

    item1 = Item.create!(name: "Pretzels", price: 100)
    item2 = Item.create!(name: "Ice Cream", price: 50)
    item3 = Item.create!(name: "Salad", price: 10)
    item4 = Item.create!(name: "Chips", price: 5)

    customer_item1 = CustomerItem.create!(customer_id: customer1.id, item_id: item1.id)
    customer_item2 = CustomerItem.create!(customer_id: customer1.id, item_id: item2.id)
    customer_item3 = CustomerItem.create!(customer_id: customer1.id, item_id: item3.id)

    visit "/customers/#{customer1.id}"

    within "#customer-supermarket" do
      expect(page).to have_content("Trader Joes")
    end

    expect(page).to_not have_content("Whole Foods")
  end

  it 'displays total price of all the customer\'s items' do
    supermarket1 = Supermarket.create!(name: "Trader Joes", location: "DC")
    supermarket2 = Supermarket.create!(name: "Whole Foods", location: "New York")

    customer1 = Customer.create!(name: "Alex", supermarket_id: supermarket1.id)
    customer2 = Customer.create!(name: "Kiara", supermarket_id: supermarket1.id)

    item1 = Item.create!(name: "Pretzels", price: 100)
    item2 = Item.create!(name: "Ice Cream", price: 50)
    item3 = Item.create!(name: "Salad", price: 10)
    item4 = Item.create!(name: "Chips", price: 5)

    customer_item1 = CustomerItem.create!(customer_id: customer1.id, item_id: item1.id)
    customer_item2 = CustomerItem.create!(customer_id: customer1.id, item_id: item2.id)
    customer_item3 = CustomerItem.create!(customer_id: customer1.id, item_id: item3.id)

    visit "/customers/#{customer1.id}"

    within "#total-price" do
      expect(page).to have_content("Total Price: 160")
    end
  end

end