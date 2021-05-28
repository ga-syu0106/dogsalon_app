FactoryBot.define do
  factory :enquete do

    know_shop { 2 }
    know_shop_comment { "アンケートコメント" }
    

    association :customer, factory: 'customer', strategy: :build
    after(:build) do |instance|
      instance.customer&.enquete = instance
    end
  end
end
