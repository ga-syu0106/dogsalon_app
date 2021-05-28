
  json.id @booking.id
  json.start_date_time @booking.start_date_time
  json.end_date_time @booking.end_date_time
  json.booking_shop_comment @booking.booking_shop_comment
  json.last_name @booking.customer.last_name
  json.pet_name @booking.pet.pet_name
  json.pet_gender @booking.pet.gender
  json.menus do 
    json.menu_name @booking.menu.pluck(:menu_name)
    json.menu_price @booking.menu.pluck(:price)
  end

  json.start_day @booking.start_date_time.to_date.to_s
  json.end_day @booking.end_date_time.to_date.to_s
  json.start_time @booking.start_date_time.strftime("%H:%M")
  json.end_time @booking.end_date_time.strftime("%H:%M")

