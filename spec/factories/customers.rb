FactoryBot.define do
  factory :customer do
    last_name { "永田" }
    first_name { "恵子" }
    furigana_last_name { "ながた" }
    furigana_first_name { "けいこ" }
    postcode { "4600000" }
    address { "東京都板橋区板橋1" }
    homephone { "0300000000" }
    mobilephone { "09000000000" }

    after(:build) do |instance|
      build('enquete', customer: instance) unless instance.enquete
    end
  end
end
