class Booking < ApplicationRecord
  belongs_to :customer
  belongs_to :pet
  has_many :booking_menus, dependent: :destroy
  has_many :menu, through: :booking_menus, dependent: :destroy
  accepts_nested_attributes_for :booking_menus
  attr_accessor :menu_id

  # validates :start_date_time, presence: true
  # validates :end_date_time, presence: true
  # validates :customer_id, presence: true
  # validates :pet_id, presence: true


end
