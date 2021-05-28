FactoryBot.define do
  # sequence(:color, %w[red green blue].cycle)
  
  factory :booking do

    start_date_time { "2021-05-10T0:00:00+09:00" }
    end_date_time { "2021-05-10T2:00:00+09:00" }
    start_last_booking { "" }
    end_last_booking { "" }
    booking_shop_comment { "水温に気を付ける" }
    
    association :pet
    customer { pet.customer }


  end
end
