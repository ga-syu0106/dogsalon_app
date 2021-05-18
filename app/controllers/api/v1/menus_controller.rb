class Api::V1::MenusController < ApplicationController
  def index
    @menus = Menu.all
    render json: @menus
  end

  def create
    menu = Menu.create(create_menus)
    if menu.save
      render json: { status: 'SUCCESS' }
    else
      render json: { status: 'ERROR' }
    end
  end

  def edit
  end


  private
  def create_menus
    params.require(:params).permit(:menu_name, :breed, :price, :working_hours)
  end

end
