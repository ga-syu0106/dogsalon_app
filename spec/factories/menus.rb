FactoryBot.define do
  factory :menu do
    menu_name { "シャンプーセット" }
    breed { 2 }
    price { 3500 }
    working_hours { "1:00" }
  end
end
