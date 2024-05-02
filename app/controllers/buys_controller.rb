class BuysController < ApplicationController

  before_action :authenticate_user!, only: [:new]
  before_action :set_item, only: [:new, :create]
  before_action :move_to_index_sold_out, only: [:new]
  before_action :move_to_index_my_item, only: [:new]

  def new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @buy_shipping_address = BuyShippingAddress.new
  end

  def create
    @buy_shipping_address = BuyShippingAddress.new(buy_params)
    if @buy_shipping_address.valid?
      pay_item
      @buy_shipping_address.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :new, status: :unprocessable_entity
    end
  end

  private

  def buy_params
    params.require(:buy_shipping_address)
          .permit(:post_code, :prefecture_id, :municipality, :street_address, :building_name, :phone_number)
          .merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def move_to_index_sold_out
    if @item.buy.present?
      redirect_to root_path
    end
  end

  def move_to_index_my_item
    if current_user == @item.user
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.selling_price,
      card: buy_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
