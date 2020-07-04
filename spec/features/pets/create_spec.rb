require "rails_helper"

RSpec.describe "shelter pets index page" do
  it "can create a new adoptable pet for the shelter" do
    shelter = Shelter.create!(name: "Shelter", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)

    visit "/shelters/#{shelter.id}/pets"
    expect(page).to_not have_content("Riley")

    click_on "Create Pet"
    expect(current_path).to eq("/shelters/#{shelter.id}/pets/new")

    fill_in :image, with: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg"
    fill_in :name, with: "Ronny"
    fill_in :description, with: "Cavalier King Charles Spaniel. 17 pounds. Brown and white color."
    fill_in :approximate_age, with: 3
    fill_in :sex, with: "male"

    click_on "Create Pet"

    expect(current_path).to eq("/shelters/#{shelter.id}/pets")
    expect(page).to have_content("Ronny")
    expect(page).to have_content("#{shelter.name}")
    expect(page).to have_content("Adoptable")
  end
end
# As a visitor
# When I visit a Shelter Pets Index page
# Then I see a link to add a new adoptable pet for that shelter "Create Pet"
# When I click the link
# I am taken to '/shelters/:shelter_id/pets/new' where I see a form to add a new adoptable pet
# When I fill in the form with the pet's:
# - image
# - name
# - description
# - approximate age
# - sex ('female' or 'male')
# And I click the button "Create Pet"
# Then a `POST` request is sent to '/shelters/:shelter_id/pets',
# a new pet is created for that shelter,
# that pet has a status of 'adoptable',
# and I am redirected to the Shelter Pets Index page where I can see the new pet listed
