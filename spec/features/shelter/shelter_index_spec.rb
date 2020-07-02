require "rails_helper"

RSpec.describe "shetler index" do
  it "displays all the names of the shelters in the system" do
    shelter_1 = Shelter.create(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    shelter_2 = Shelter.create(name: "Shelter 2", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)

    visit "/shelters"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
  end
end

# As a visitor
# When I visit '/shelters'
# Then I see the name of each shelter in the system
