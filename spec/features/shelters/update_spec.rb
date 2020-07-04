require "rails_helper"

RSpec.describe "update shelter" do
  describe "when I visit a shelter show page" do
    it "can update the shelter" do
      shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)

      visit "/shelters/#{shelter_1.id}"
      expect(page).to have_content("Shelter 1")

      click_on "Edit #{shelter_1.name}"
      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

      fill_in :name, with: "Updated Pet Shelter"

      click_on "Update Shelter"
      expect(current_path).to eq('/shelters')

      expect(page).to have_content("Updated Pet Shelter")
      expect(page).to_not have_content("Shelter 1")
    end
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
