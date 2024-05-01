class BuyShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id , :post_code, :prefecture_id, :municipality, :street_address, :building_name, :phone_number, :token

  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :post_code, presence: true,   format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :prefecture_id, presence: true, numericality: { other_than: 1 , message: "can't be blank"}
  validates :municipality, presence: true
  validates :street_address, presence: true
  validates :phone_number, presence: true, length: { minimum: 10, maximum: 11 }, format: { with: /\A[0-9]+\z/, message: "is not a number" }
  validates :token, presence: true

  def save

    buy = Buy.create(user_id: user_id,item_id: item_id)

    ShippingAddress.create(post_code: post_code, prefecture_id: prefecture_id, municipality: municipality,
                           street_address: street_address, building_name: building_name, phone_number: phone_number, buy_id: buy.id)
  end

end
