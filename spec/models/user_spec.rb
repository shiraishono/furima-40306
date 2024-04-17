require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'nameとemail、passwordとpassword_confirmation、last_nameとfirst_name、last_name_kanaとfirst_name_kana、birth_dateが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'user11'
        @user.password_confirmation = 'user10'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordは数字だけでは登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end

      it 'passwordは英語だけでは登録できない' do
        @user.password = 'sos'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end

      it 'パスワードが6文字未満では登録できない' do
        @user.password = 'sos11'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードに全角文字を含むと登録できない' do
        @user.password = 'ｓos11'
        @user.password_confirmation = 'ｓos111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'last_nameが半角では登録できない' do
        @user.last_name = 'ｵｶｶ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name Input full-width characters')
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'first_nameが半角では登録できない' do
        @user.first_name = 'ﾂﾅﾏﾖ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name Input full-width characters')
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'last_name_kanaがひらがなと漢字では登録できない' do
        @user.last_name_kana = '鮭さけ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters')
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'first_name_kanaがひらがなと漢字では登録できない' do
        @user.first_name_kana = '昆布おにぎり'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters')
      end

      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
