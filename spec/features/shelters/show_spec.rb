require "rails_helper"

RSpec.describe "shelter show" do
  it "displays the shelter with that id including the shelter's: name, address, city, state and zip" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    shelter_2 = Shelter.create!(name: "Shelter 2", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content("Name: #{shelter_1.name}")
    expect(page).to have_content("Address: #{shelter_1.address}")
    expect(page).to have_content("City: #{shelter_1.city}")
    expect(page).to have_content("State: #{shelter_1.state}")
    expect(page).to have_content("Zip: #{shelter_1.zip}")

    expect(page).to_not have_content(shelter_2.name)
  end
end

# As a visitor
# When I visit '/shelters/:id'
# Then I see the shelter with that id including the shelter's:
# - name
# - address
# - city
# - state
# - zip
