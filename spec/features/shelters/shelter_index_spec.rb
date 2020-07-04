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

  it "can click on shelter's name anywhere on page and be taken to shelter's show page" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter_id: shelter_1.id)

    visit "shelters"

    expect(page).to have_link("#{shelter_1.name}", count: 1, exact: true)
  end

  it "can click on a 'Shelter' link redirect me back to shelter index page" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter_id: shelter_1.id)

    visit "shelters"

    expect(page).to have_link("Shelters", count: 1, exact: true)
  end

  it "can click on a 'Pets' link redirect me back to pet index page" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter_id: shelter_1.id)

    visit "shelters"

    expect(page).to have_link("Pets", count: 1, exact: true)
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
