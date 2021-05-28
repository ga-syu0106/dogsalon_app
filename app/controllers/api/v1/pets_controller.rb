class Api::V1::PetsController < ApplicationController
  before_action :set_pet, only: [:show, :edit, :update]

  def index

    @pets = Pet.all
    @bookings = Booking.all
    render :formats => :json and return
  end

  def show
    @pets = Pet.where(customer_id: @pet.customer_id)
    @bookings = Booking.where(pet_id: params[:id])
    render :formats => :json and return
  end

  def edit

  end

  def update
    if @pet.update(pet_params)
      @pet.parse_base64(params[:image])
      render json: @pet, status: :updated, location: @pet
    else
      render json: @pet.errors, status: :unprocessable_entoty
    end
  end

  private
    def set_pet
      @pet = Pet.find(params[:id])
    end

    def pet_params
      params.require(:pet).petmit(:image)
    end
end
