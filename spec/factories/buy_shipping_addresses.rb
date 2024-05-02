FactoryBot.define do
  factory :buy_shipping_address do
    post_code { '123-4567' }
    prefecture_id { '2' }
    municipality { 'おにぎり市おかか町' }
    street_address { '0丁目2番地' }
    building_name { 'おにぎり亭202号室' }
    phone_number { '09002020202' }
    token {"tok_abcdefghijk00000000000000000"}

  end
end
