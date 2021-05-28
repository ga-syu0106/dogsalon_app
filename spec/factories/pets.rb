FactoryBot.define do
  factory :pet do
    pet_name { "ノエ" }
    breed { 2 }
    birthday { "2018-07-16T12:00:00+09:00" }
    gender { 2 }
    pet_comment { "シャンプー嫌がります" }
    vaccine_day { "2021-03-15T12:00:00+09:00" }
    hospital_name { "やながわペットクリニック" }
    dermatitis { true }
    dermatitis_comment { "一ヶ月前からです" }
    disease { true }
    disease_comment { "以前ありましたが、治りました" }
    flea { false }
    flea_comment { "問題ありません" }
    customer_request { "今風でお願いします" }
    customer
  end
end
