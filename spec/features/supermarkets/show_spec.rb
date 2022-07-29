require 'rails_helper'

RSpec.describe 'supermarket show page' do

  it 'displays name of the supermarket' do
    supermarket1 = Supermarket.create!(name: "Trader Joes", location: "DC")
    supermarket2 = Supermarket.create!(name: "Whole Foods", location: "New York")

    visit "/supermarkets/#{supermarket1.id}"

    within "#supermarket-name" do
      expect(page).to have_content("Supermarket Name: Trader Joes")
    end

    expect(page).to_not have_content("Whole Foods")
  end

  it 'has a link to view all of the items that supermarket has' do
    supermarket1 = Supermarket.create!(name: "Trader Joes", location: "DC")
    supermarket2 = Supermarket.create!(name: "Whole Foods", location: "New York")

    visit "/supermarkets/#{supermarket1.id}"

    within "#view-all-items-link" do
      click_link "View All Items"
    end

    expect(current_path).to eq("/supermarkets/#{supermarket1.id}/items")
  end

  xit 'displays three most popular items based on how many customers are associated with each item' do
    supermarket1 = Supermarket.create!(name: "Trader Joes", location: "DC")

    customer1 = Customer.create!(name: "Alex", supermarket_id: supermarket1.id)
    customer2 = Customer.create!(name: "Kate", supermarket_id: supermarket1.id)
    customer3 = Customer.create!(name: "Kiara", supermarket_id: supermarket1.id)
    customer4 = Customer.create!(name: "Doug", supermarket_id: supermarket1.id)
    customer5 = Customer.create!(name: "Jeff", supermarket_id: supermarket1.id)

    item1 = Item.create!(name: "Pretzels", price: 100)
    item2 = Item.create!(name: "Ice Cream", price: 50)
    item3 = Item.create!(name: "Salad", price: 10)
    item4 = Item.create!(name: "Chips", price: 5)
    item5 = Item.create!(name: "Soup", price: 5)

    customer1_item1 = CustomerItem.create!(customer_id: customer1.id, item_id: item1.id)
    customer2_item1 = CustomerItem.create!(customer_id: customer2.id, item_id: item1.id)
    customer3_item1 = CustomerItem.create!(customer_id: customer3.id, item_id: item1.id)
    customer4_item1 = CustomerItem.create!(customer_id: customer4.id, item_id: item1.id)
    customer5_item1 = CustomerItem.create!(customer_id: customer5.id, item_id: item1.id)

    # 5 customers for item 1

    customer1_item2 = CustomerItem.create!(customer_id: customer1.id, item_id: item2.id)
    customer2_item2 = CustomerItem.create!(customer_id: customer2.id, item_id: item2.id)
    customer3_item2 = CustomerItem.create!(customer_id: customer3.id, item_id: item2.id)

    # 3 customers for item 2

    customer1_item3 = CustomerItem.create!(customer_id: customer1.id, item_id: item3.id)
    customer2_item3 = CustomerItem.create!(customer_id: customer2.id, item_id: item3.id)

    # 2 customers for item 3

    customer1_item4 = CustomerItem.create!(customer_id: customer1.id, item_id: item4.id)

    # 1 customer for item 4

    visit "/supermarkets/#{supermarket1.id}"

    within "#popular-item-1" do
      expect(page).to have_content("Pretzels")
    end

    within "#popular-item-2" do
      expect(page).to have_content("Ice Cream")
    end

    within "#popular-item-3" do
      expect(page).to have_content("Salad")
    end

  end

end
