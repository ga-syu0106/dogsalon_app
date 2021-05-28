class Api::V1::BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :destroy]
  def index
    # 1.ペット情報でも検索できるようにする。フォームに追加する。
    # 2.検索フォーム日付欄、犬種欄
    # 3.入力フォームのリセットボタンを作る
    # 4.細部デザインをモックに近づける
    # 5.一覧は予約日時基準でソート。今日から未来。
    # 6.予約日時などの記載を修正する
    # 7.「全て表示」「一週間前まで」「昨日」「今日」「明日」「一週間後まで」で今表示中のデータをフィルター
    

      search_ransack = Customer.ransack(search_params)
      customer = search_ransack.result.pluck(:id)
      customer_data = Booking.where(customer_id: customer).where("start_date_time > ?",Date.today).order(start_date_time: :ASC)
      @bookings = customer_data.includes(:customer, :pet, :menu)
      
      @booking_count = @bookings.count.to_i
      render :formats => :json and return

  end

  def new
    search_ransack = Customer.ransack(search_params)
    customer = search_ransack.result.pluck(:id)
    pet_data = Pet.where(customer_id: customer)
    @pets = pet_data.includes(:customer)
    @pet_count = @pets.count.to_i
 
    render :formats => :json and return
  end

  def create

    booking = Booking.new(create_bookings)
    menu_array = create_bookings[:menu_id]
    last_booking = Booking.where(pet_id: booking.pet_id).order(start_date_time: :desc).limit(1)
    booking.customer_id = last_booking.first.customer_id
    booking.start_last_booking = last_booking.first.start_date_time
    booking.end_last_booking = last_booking.first.end_date_time
 
    if booking.save
      menu_array.each do |menu|
        booking_menu = BookingMenu.new
        booking_menu.booking_id = booking.id
        booking_menu.menu_id = menu
        booking_menu.save
      end
      render json: { status: 'SUCCESS' }
    else
      render json: { status: 'ERROR' }
    end

    # booking.start_last_booking


    # Booking.create!(
    #   { start_date_time:, end_date_time:, start_last_booking: start_last_booking, end_last_booking: end_last_booking, booking_shop_comment: booking_shop_comment, customer_id: customer_id, pet_id: pet_id, menu_id: menu_id}
    # )start_last_booking: , end_last_booking:

    # (:start_date_time, :end_date_time, :customer_id, :pet_id, :menu_id, :breed, :booking_shop_comment)

    # BookingMenu.create!(
    #   { booking_id: booking_id, menu_id: menu_id}

  end


  def show
    render json: @booking
  end

  def edit
    @booking = Booking.includes(:customer, :pet, :menu).find_by_id(params[:id])
    render :formats => :json and return
  end

  def update

    @booking = Booking.find_by(id: params[:id])

    if @booking.update_attributes(booking_edit)
      render json: { status: 'SUCCESS' }
    else
      render json: { status: 'ERROR' }
    end
    
  end

  def destroy

    @booking.destroy!
  end

  def oneday
    # one_date = params[:date].to_datetime
    one_date_bookings = Booking.where(start_date_time: one_date.beginning_of_day..one_date.end_of_day)
    @bookings = one_date_bookings.includes(:customer, :pet, :menu)
    render json: @bookings
  end

  def month
    @bookings = Booking.includes(:customer, :pet, :menu)
    @booking_count = @bookings.count.to_i
    render :formats => :json and return
  end

  def menus

    @menus = Menu.where(breed: params[:breed])
    render json: @menus
    
  end

  private
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def search_params
      params.require(:q).permit(:last_name_eq, :mobilephone_eq, :start_date_time)
    end

    def create_bookings
      params.require(:params).permit(:start_date_time, :end_date_time, :customer_id, :pet_id, :booking_shop_comment, menu_id: [])
    end

    def booking_edit
      params.require(:params).permit(:start_date_time, :end_date_time, :booking_shop_comment)
    end
end
