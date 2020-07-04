require "rails_helper"

RSpec.describe "pets show page" do
  it "displays the the pet with that id including the pet's: image, name, description, approximate age, sex, adoptable/pending adoption status" do

    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter: shelter_1, status: "Adoptable")

    visit "/pets/#{pet_1.id}"

    expect(page).to have_xpath("//img[@src='https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg' and @alt='Riley']")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content("Status: #{pet_1.status}")
  end
end

# As a visitor
# When I visit '/pets/:id'
# Then I see the pet with that id including the pet's:
# - image
# - name
# - description
# - approximate age
# - sex
# - adoptable/pending adoption status
