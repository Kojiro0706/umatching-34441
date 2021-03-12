require 'rails_helper'

RSpec.describe Builder, type: :model do
  describe '新規投稿登録' do
    before do
      @builder= FactoryBot.build(:builder)
    end
  
    context '投稿情報の登録が上手くいくとき' do
      it 'すべての情報が適切に入力されていれば登録できること' do
        expect(@builder).to be_valid
      end
      it 'お気に入りの競馬場以外が入力されていれば登録出来ること' do
        @builder.place= ''
        expect(@builder).to be_valid
      end
    end
    context '投稿情報の登録が上手くいかないとき' do
      it '投稿画像が空だと登録できないこと' do
        @builder.image= nil
        @builder.valid?
        expect(@builder.errors.full_messages).to include("Image can't be blank")
      end
      it 'タイトルが空だと登録できないこと' do
        @builder.title= ''
        @builder.valid?
        expect(@builder.errors.full_messages).to include("Title can't be blank")
      end
      it '投稿の説明が空だと登録できないこと' do
        @builder.description= ''
        @builder.valid?
        expect(@builder.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリーがID:1だと登録できないこと' do
        @builder.category_id= ''
        @builder.valid?
        expect(@builder.errors.full_messages).to include("Category can't be blank")
      end
      it 'Userが紐付いてないと登録できないこと' do
        @builder.user= nil
        @builder.valid?
        expect(@builder.errors.full_messages).to include("User must exist")
      end
    end
  end
end
