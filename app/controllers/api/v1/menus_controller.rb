class Api::V1::MenusController < ApplicationController
  before_action :set_menu, only: [:update, :destroy]


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

  def update
    if @menu.update(create_menus)
      render json: { status: 'SUCCESS' }
    else
      debugger
      render json: { status: 'ERROR' }
    end
  end

  def destroy
    @menu.destroy
    render json: { status: 'SUCCESS' }
  end


  private
  def create_menus
    params.require(:params).permit(:menu_name, :breed, :price, :working_hours)
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end
end
