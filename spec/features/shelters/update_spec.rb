require "rails_helper"

RSpec.describe "update shelter" do
  describe "when I visit a shelter show page" do
    it "can update the shelter" do
      shelter_1 = Shelter.create!(name: "Doggo", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)

      visit "/shelters/#{shelter_1.id}"
      expect(page).to have_content("Doggo")

      click_on "Edit #{shelter_1.name}"
      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

      fill_in :name, with: "Pet Shelter"

      click_on "Update Shelter"
      expect(current_path).to eq('/shelters')

      expect(page).to have_content("Pet Shelter")
      expect(page).to_not have_content("Doggo")
    end
  end

  it "can click on shelter's name anywhere on page and be taken to shelter's show page" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter_id: shelter_1.id)

    visit "shelters/#{shelter_1.id}/edit"

    expect(page).to have_link("#{shelter_1.name}", count: 1, exact: true)
  end

  it "can click on a 'Shelter' link redirect me back to shelter index page" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter_id: shelter_1.id)

    visit "shelters/#{shelter_1.id}/edit"

    expect(page).to have_link("Shelters", count: 1, exact: true)
  end

  it "can click on a 'Pets' link redirect me back to pet index page" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter_id: shelter_1.id)

    visit "shelters/#{shelter_1.id}/edit"

    expect(page).to have_link("Pets", count: 1, exact: true)
  end
end

# As a visitor
# When I visit a shelter show page
# Then I see a link to update the shelter "Update Shelter"
# When I click the link "Update Shelter"
# Then I am taken to '/shelters/:id/edit' where I  see a form to edit the shelter's data including:
# - name
# - address
# - city
# - state
# - zip
# When I fill out the form with updated information
# And I click the button to submit the form
# Then a `PATCH` request is sent to '/shelters/:id',
# the shelter's info is updated,
# and I am redirected to the Shelter's Show page where I see the shelter's updated info
