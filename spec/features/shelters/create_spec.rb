require "rails_helper"

RSpec.describe "create new shelter" do
  describe "when I visit shleter idex page" do
    it "can follow link to create a new shelter" do

      visit '/shelters'
      expect(page).to_not have_content("Pet Shelter")

      click_on "New Shelter"
      expect(current_path).to eq('/shelters/new')

      fill_in :name, with: "Pet Shelter"
      fill_in :address, with: "123 Shelter Ln"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: 80207

      click_on "Create Shelter"

      expect(current_path).to eq('/shelters')
      expect(page).to have_content("Pet Shelter")
    end
  end

  it "can click on a 'Shelter' link redirect me back to shelter index page" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter_id: shelter_1.id)

    visit "/shelters/new"

    expect(page).to have_link("Shelters", count: 1, exact: true)
  end

  it "can click on a 'Pets' link redirect me back to pet index page" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter_id: shelter_1.id)

    visit "/shelters/new"

    expect(page).to have_link("Pets", count: 1, exact: true)
  end
end

# As a visitor
# When I visit the Shelter Index page
# Then I see a link to create a new Shelter, "New Shelter"
# When I click this link
# Then I am taken to '/shelters/new' where I  see a form for a new shelter
# When I fill out the form with a new shelter's:
# - name
# - address
# - city
# - state
# - zip
# And I click the button "Create Shelter" to submit the form
# Then a `POST` request is sent to '/shelters',
# a new shelter is created,
# and I am redirected to the Shelter Index page where I see the new Shelter listed.
