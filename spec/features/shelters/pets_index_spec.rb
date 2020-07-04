require "rails_helper"

RSpec.describe "shelter pet index page" do
  it "displays all pets including the pet's image, name, approximate_age, sex and name of the shelter they're in" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter_id: shelter_1.id)
    shelter_2 = Shelter.create!(name: "Shelter 2", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_2 = Pet.create!(image: "https://mymodernmet.com/wp/wp-content/uploads/2019/11/dogs-are-the-best-people-frog-dog-studios-16-1024x683.jpg", name: "Toki", approximate_age: 7, sex: "Male", shelter_id: shelter_2.id)

    visit "/shelters/#{shelter_1.id}/pets"

    expect(page).to have_xpath("//img[@src='https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg' and @alt='Riley']")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.approximate_age)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_content(pet_1.shelter.name)

    expect(page).to_not have_content(pet_2.name)
  end
  it "can update each pet" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter_id: shelter_1.id)
    pet_2 = Pet.create!(image: "https://mymodernmet.com/wp/wp-content/uploads/2019/11/dogs-are-the-best-people-frog-dog-studios-16-1024x683.jpg", name: "Toki", approximate_age: 7, sex: "Male", shelter_id: shelter_1.id)

    visit "/shelters/#{shelter_1.id}/pets"
    expect(page).to have_content("Edit #{pet_1.name}")
    expect(page).to have_content("Edit #{pet_2.name}")

    click_on "Edit #{pet_1.name}"
    expect(current_path).to eq("/pets/#{pet_1.id}/edit")

    fill_in :name, with: "Justin"
    click_on "Update Pet"
    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).to have_content("Justin")
    expect(page).to_not have_content("#{pet_1.name}")

    visit "/shelters/#{shelter_1.id}/pets"
    expect(page).to have_content("Justin")
    expect(page).to have_content("#{pet_2.name}")
  end
  it "can delete each pet" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter_id: shelter_1.id)
    pet_2 = Pet.create!(image: "https://mymodernmet.com/wp/wp-content/uploads/2019/11/dogs-are-the-best-people-frog-dog-studios-16-1024x683.jpg", name: "Toki", approximate_age: 7, sex: "Male", shelter_id: shelter_1.id)

    visit "/shelters/#{shelter_1.id}/pets"
    expect(page).to have_content("Delete #{pet_1.name}")
    expect(page).to have_content("Delete #{pet_2.name}")

    click_on "Delete #{pet_1.name}"
    expect(current_path).to eq("/pets")
    expect(page).to_not have_content("#{pet_1.name}")
    expect(page).to have_content("#{pet_2.name}")
  end
end

# As a visitor
# When I visit '/shelters/:shelter_id/pets'
# Then I see each Pet that can be adopted from that Shelter with that shelter_id including the Pet's:
# - image
# - name
# - approximate age
# - sex

# As a visitor
# When I visit the pets index page or a shelter pets index page
# Next to every pet, I see a link to edit that pet's info
# When I click the link
# I should be taken to that pets edit page where I can update its information just like in User Story 11

# As a visitor
# When I visit the pets index page or a shelter pets index page
# Next to every pet, I see a link to delete that pet
# When I click the link
# I should be taken to the pets index page where I no longer see that pet
