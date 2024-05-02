class Item < ApplicationRecord
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :product_category
  belongs_to_active_hash :product_condition
  belongs_to_active_hash :shipping_charge
  belongs_to_active_hash :region_of_origin
  belongs_to_active_hash :shipping_day

  belongs_to :user
  has_one_attached :image
  has_one :buy


  with_options presence: true do
    validates :product_category_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :product_condition_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :shipping_charge_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :region_of_origin_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :shipping_day_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :product_name
    validates :product_description
    validates :selling_price, numericality: { only_integer: true,
                                              greater_than_or_equal_to: 300,
                                              less_than_or_equal_to: 9999999,
                                              message: "is not a valid price" }
    validates :image
  end
end
