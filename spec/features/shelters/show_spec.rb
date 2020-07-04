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

  it "can click on pet's name anywhere on page and be taken to pet's show page" do

    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter_id: shelter_1.id)

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_link("#{pet_1.name}", count: 1, exact: true)
  end

  it "can click on shelter's name anywhere on page and be taken to shelter's show page" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter_id: shelter_1.id)

    visit "shelters/#{shelter_1.id}"

    expect(page).to have_link("#{shelter_1.name}", count: 2, exact: true)
  end

  it "can click on a 'Shelter' link redirect me back to shelter index page" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter_id: shelter_1.id)

    visit "shelters/#{shelter_1.id}"

    expect(page).to have_link("Shelters", count: 1, exact: true)
  end

  it "can click on a 'Pets' link redirect me back to pet index page" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter_id: shelter_1.id)

    visit "shelters/#{shelter_1.id}"

    expect(page).to have_link("Pets", count: 1, exact: true)
  end

  it "can click on a link to take me to the shelter's pet page" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter_id: shelter_1.id)

    visit "shelters/#{shelter_1.id}"
    expect(page).to have_link("See all of #{shelter_1.name}'s pets", count: 1, exact: true)

    click_on "See all of #{shelter_1.name}'s pets"
    expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")
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

# As a visitor
# When I visit a shelter show page ('/shelters/:id')
# Then I see a link to take me to that shelter's pets page ('/shelters/:id/pets')
