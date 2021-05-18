class Api::V1::PetsController < ApplicationController
  before_action :set_pet, only: [:show]

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

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destory
  end


  private
    def set_pet
      @pet = Pet.find(params[:id])
    end
end
