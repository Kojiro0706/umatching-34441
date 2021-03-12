require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end
    context 'ユーザーが保存できる場合' do
      it '全て適切に入力されていれば登録できること' do
        expect(@user).to be_valid
      end
      it 'お気に入りの競走馬以外入力されていれば登録できること' do
        @user.horse= ''
        expect(@user).to be_valid
      end
    end
    context 'ユーザーが保存できない場合' do
      it 'nameが空だと登録できないこと' do
        @user.name= ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end
      it 'emailが空だと登録できないこと' do
        @user.email= ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailに一意性がないと登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'パスワードが６文字以上でないと登録できないこと' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードが英字だけだと登録できないこと' do
        @user.password = 'ABCabc'
        @user.password_confirmation = 'ABCabc'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードが全角だと登録できないこと' do
        @user.password = '１２３ＡＢＣ'
        @user.password_confirmation = '１２３ＡＢＣ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードが半角英数字混合でないと登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'password_confirmationが空では登録できないこと' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'プロフィールが空だと登録できないこと' do
        @user.profile= ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Profile can't be blank")
      end
      it '馬女歴が空だと登録できないこと' do
        @user.history= nil
        @user.valid?
        expect(@user.errors.full_messages).to include("History can't be blank")
      end
    end
  end
end