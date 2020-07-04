class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    new_pet = shelter.pets.create(pet_params)
    new_pet.status = "Adoptable"
    new_pet.save
    redirect_to("/shelters/#{shelter.id}/pets")
  end

  private
  def pet_params
    params.permit(:image, :name, :description, :approximate_age, :sex, :status)
  end
end
