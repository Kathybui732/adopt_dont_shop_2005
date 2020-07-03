require "rails_helper"

RSpec.describe "pet index page" do
  it "displays all pets including the pet's image, name, approximate_age, sex and name of the shelter they're in" do
    shelter_1 = Shelter.create!(name: "Shelter 1", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_1 = Pet.create!(image: "https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg", name: "Riley", approximate_age: 3, sex: "Male", shelter: shelter_1)
    shelter_2 = Shelter.create!(name: "Shelter 2", address: "123 shelter lane", city: "Denver", state: "CO", zip: 80207)
    pet_2 = Pet.create!(image: "https://mymodernmet.com/wp/wp-content/uploads/2019/11/dogs-are-the-best-people-frog-dog-studios-16-1024x683.jpg", name: "Toki", approximate_age: 7, sex: "Male", shelter: shelter_2)

    visit "/pets"

    expect(page).to have_xpath("//img[@src='https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg' and @alt='Riley']")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.approximate_age)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_content(pet_1.shelter.name)


    expect(page).to have_content(pet_1.name)
  end
end

# As a visitor
# When I visit '/pets'
# Then I see each Pet in the system including the Pet's:
# - image
# - name
# - approximate age
# - sex
# - name of the shelter where the pet is currently located
