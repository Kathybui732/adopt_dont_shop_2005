require "rails_helper"

RSpec.describe "shetler index" do
  it "displays all the names of the shelters in the system" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    shelter_2 = Shelter.create!(name: "Shelter 2", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)

    visit "/shelters"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
  end
  it "can update every shelter" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    shelter_2 = Shelter.create!(name: "Shelter 2", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)

    visit "/shelters"
    expect(page).to have_content("Edit #{shelter_1.name}")
    expect(page).to have_content("Edit #{shelter_2.name}")

    click_on "Edit #{shelter_1.name}"
    expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

    fill_in :name, with: "New name"

    click_on "Update Shelter"
    expect(current_path).to eq("/shelters")
    expect(page).to_not have_content("Edit #{shelter_1.name}")
    expect(page).to have_content("New name")
  end
  it "can delete each shelter" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    shelter_2 = Shelter.create!(name: "Shelter 2", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)

    visit "/shelters"
    expect(page).to have_content("Delete #{shelter_1.name}")
    expect(page).to have_content("Delete #{shelter_2.name}")

    click_on "Delete #{shelter_2.name}"
    expect(current_path).to eq("/shelters")
    expect(page).to have_content("Delete #{shelter_1.name}")
    expect(page).to_not have_content("Delete #{shelter_2.name}")
  end
end

# As a visitor
# When I visit '/shelters'
# Then I see the name of each shelter in the system

# As a visitor
# When I visit the shelter index page
# Next to every shelter, I see a link to edit that shelter's info
# When I click the link
# I should be taken to that shelters edit page where I can update its information just like in User Story 5

# As a visitor
# When I visit the shelter index page
# Next to every shelter, I see a link to delete that shelter
# When I click the link
# I am returned to the Shelter Index Page where I no longer see that shelter
