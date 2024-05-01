require 'rails_helper'

RSpec.describe BuyShippingAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @buy_shipping_address = FactoryBot.build(:buy_shipping_address, user_id: @user.id, item_id: @item.id)
    sleep(1)
  end

  describe '商品購入' do
    context '商品が購入できる場合' do
      it 'post_code, prefecture_id, municipality, street_address, building_name, phone_number, tokenが存在すれば保存できる' do
        expect(@buy_shipping_address).to be_valid
      end
      it 'building_nameは空でも保存できる' do
        @buy_shipping_address.building_name = ''
        expect(@buy_shipping_address).to be_valid
      end
    end

    context '商品が購入できない場合' do
      it 'post_codeが空だと保存できない' do
        @buy_shipping_address.post_code = ''
        @buy_shipping_address.valid?
        expect(@buy_shipping_address.errors.full_messages).to include("Post code can't be blank")
      end
    it 'post_codeが3桁ハイフン4桁の半角文字列でないと保存できない' do
        @buy_shipping_address.post_code = '1234567'
        @buy_shipping_address.valid?
        expect(@buy_shipping_address.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it 'prefecture_idが空だと保存できない' do
        @buy_shipping_address.prefecture_id = ''
        @buy_shipping_address.valid?
        expect(@buy_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県に「---」が選択されている場合は保存できない' do
        @buy_shipping_address.prefecture_id = '1'
        @buy_shipping_address.valid?
        expect(@buy_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'municipalityが空だと保存できない' do
        @buy_shipping_address.municipality = ''
        @buy_shipping_address.valid?
        expect(@buy_shipping_address.errors.full_messages).to include("Municipality can't be blank")
      end
     it 'street_addressが空だと保存できない' do
        @buy_shipping_address.street_address = ''
        @buy_shipping_address.valid?
        expect(@buy_shipping_address.errors.full_messages).to include("Street address can't be blank")
      end
      it 'phone_numberが空だと保存できない' do
        @buy_shipping_address.phone_number = ''
        @buy_shipping_address.valid?
        expect(@buy_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが9桁以下だと保存できない' do
        @buy_shipping_address.phone_number = '123456789'
        @buy_shipping_address.valid?
        expect(@buy_shipping_address.errors.full_messages).to include("Phone number is too short (minimum is 10 characters)")
      end
      it 'phone_numberが12桁以上だと保存できない' do
        @buy_shipping_address.phone_number = '123456789012'
        @buy_shipping_address.valid?
        expect(@buy_shipping_address.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end
      it 'phone_numberが全角数値だと保存できない' do
        @buy_shipping_address.phone_number = '０９００２０２０２０２'
        @buy_shipping_address.valid?
        expect(@buy_shipping_address.errors.full_messages).to include("Phone number is not a number")
      end
      it 'userが紐づいていないと保存できない' do
        @buy_shipping_address.user_id = nil
        @buy_shipping_address.valid?
        expect(@buy_shipping_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐づいていないと保存できない' do
        @buy_shipping_address.item_id = nil
        @buy_shipping_address.valid?
        expect(@buy_shipping_address.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空だと保存できない' do
        @buy_shipping_address.token = ''
        @buy_shipping_address.valid?
        expect(@buy_shipping_address.errors.full_messages).to include("Token can't be blank")
      end

    end
  end
end
