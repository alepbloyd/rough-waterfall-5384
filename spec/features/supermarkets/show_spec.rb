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

end

# Story 3 of 3
# As a visitor,
# When I visit a supermarket show page,
# I see the name of that supermarket,
# And I see a link to view all of the items that the supermarket has
# And when I click on the link,
# I am taken to the supermarkets item index page,
# And I can see a UNIQUE list of all the items that the supermarket has