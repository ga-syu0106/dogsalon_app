json.pet do
  json.extract! @pet, :id, :pet_name, :breed, :birthday, :gender, :pet_comment, :vaccine_day, :hospital_name, :dermatitis, :dermatitis_comment, :disease, :disease_comment, :flea, :flea_comment
  json.image rails_blob_url(@pet.pet_image) if @pet.pet_image.attached?

end

json.customer do
  json.extract! @pet.customer, :last_name, :first_name, :furigana_last_name, :furigana_first_name, :postcode, :address, :homephone, :mobilephone
end

if @pet.customer.enquete != nil
  json.enquete do
    json.extract! @pet.customer.enquete, :know_shop, :know_shop_comment
  end
end

json.pets do
  json.array! @pets, :pet_name, :breed, :birthday
end

json.menus do
  json.array! @bookings do |booking|
    json.menu_name booking.menu.pluck(:menu_name)
    json.price booking.menu.pluck(:price)
    json.start_last_booking booking.start_last_booking
  end
end