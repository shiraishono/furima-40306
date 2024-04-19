require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品が出品できる場合' do
      it 'product_name,product_description,selling_price,product_category_id,product_condition_id,region_of_origin_id,shipping_day_id,shipping_charge_id,imageが存在していれば保存できる' do
        expect(@item).to be_valid
      end
    end
    context '商品が出品できない場合' do
      it 'product_nameが空では保存できない' do
        @item.product_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product name can't be blank")
      end
      it 'product_descriptionが空では保存できない' do
        @item.product_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product description can't be blank")
      end
      it 'selling_priceが空では保存できない' do
        @item.selling_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price can't be blank")
      end
      it 'selling_priceが半角数値以外では保存できない' do
        @item.selling_price = '２００００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price is not a valid price")
      end
      it 'selling_priceが300未満では保存できない' do
        @item.selling_price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price is not a valid price")
      end
      it 'selling_priceが10000000以上では保存できない' do
        @item.selling_price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price is not a valid price")
      end
      it 'product_category_idが1(表記：---)では保存できない' do
        @item.product_category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Product category can't be blank")
      end
      it 'product_condition_idが1(表記：---)では保存できない' do
        @item.product_condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Product condition can't be blank")
      end
      it 'region_of_origin_idが1(表記：---)では保存できない' do
        @item.region_of_origin_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Region of origin can't be blank")
      end
      it 'shipping_day_idが1(表記：---)では保存できない' do
        @item.shipping_day_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day can't be blank")
      end
      it 'shipping_charge_idが1(表記：---)では保存できない' do
        @item.shipping_charge_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping charge can't be blank")
      end
      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
      it 'imageが空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

    end
  end
end
