require "rails_helper"

RSpec.describe "pet show page" do
  it "can delete a pet" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter: shelter_1)

    visit "/pets/#{pet_1.id}"
    expect(page).to have_content("#{pet_1.name}")
    click_on "Delete Pet"

    expect(current_path).to eq("/pets")
    expect(page).to_not have_content("#{pet_1.name}")
  end

end

# As a visitor
# When I visit a pet show page
# Then I see a link to delete the pet "Delete Pet"
# When I click the link
# Then a 'DELETE' request is sent to '/pets/:id',
# the pet is deleted,
# and I am redirected to the pet index page where I no longer see this pet
