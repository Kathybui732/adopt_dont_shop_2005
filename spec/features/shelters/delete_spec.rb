require "rails_helper"

RSpec.describe "delete shelter from index" do
  describe "I visit a shelter show page" do
    it "can display a link and delete the shelter" do
      shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)

      visit "/shelters"
      expect(page).to have_content("Shelter 1")

      visit "/shelters/#{shelter_1.id}"

      click_on "Delete Shelter"

      expect(current_path).to eq('/shelters')
      expect(page).to_not have_content("Shelter 1")
    end
  end
end

# As a visitor
# When I visit a shelter show page
# Then I see a link to delete the shelter
# When I click the link "Delete Shelter"
# Then a 'DELETE' request is sent to '/shelters/:id',
# the shelter is deleted,
# and I am redirected to the shelter index page where I no longer see this shelter
