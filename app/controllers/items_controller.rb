class ItemsController < ApplicationController

  #before_action :authenticate_user!, only: [:new, :edit ,:destroy]
  #before_action :move_to_index, only: [:edit]
  #before_action :move_to_index_sold_out, only: [:edit]
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :authenticate_user!, only: [:new]

  #def index
    #@items = Item.all.order("created_at DESC")
  #end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品が正常に登録されました。'
    else
      # ステータスコード422 (Unprocessable Entity) を付与してnewテンプレートを再表示
      render :new, status: :unprocessable_entity
    end
  end

  #def show
  #end

  #def edit
  #end

  #def update
    #if @item.update(item_params)
      #redirect_to item_path(@item.id)
    #else
      #render :edit
    #end
  #end

  #def destroy
    #@item.destroy
    #redirect_to root_path
  #end

  private

  def item_params
    params.require(:item).permit(:product_name,:product_description,:product_category_id,:product_condition_id,:shipping_charge_id,:region_of_origin_id,:shipping_day_id,:selling_price,:image).merge(user_id: current_user.id)
  end

  #def move_to_index
    #@item = Item.find(params[:id])
    #unless user_signed_in? && current_user == @item.user
      #redirect_to action: :index
    #end
  #end

  #def move_to_index_sold_out
    #@item = Item.find(params[:id])
    #if @item.buy.present?
      #redirect_to action: :index
    #end
  #end

  def set_item
    @item = Item.find(params[:id])
  end
end
