FactoryBot.define do
  factory :item do
    product_name               {'2'}
    product_description        {'おにぎりおかかです'}
    product_category_id        {'2'}
    product_condition_id       {'2'}
    region_of_origin_id        {'2'}
    shipping_charge_id         {'2'}
    shipping_day_id            {'2'}
    selling_price              {'20000'}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
