require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '新規コメント登録' do
    before do
      @comment = FactoryBot.build(:comment)
    end
    context 'コメント情報の登録が上手くいくとき' do
      it 'すべての情報が適切に入力されていれば登録できること' do
        expect(@comment).to be_valid
      end
    end
    context 'コメント情報の登録が上手くいかないとき' do
      it 'コメントが空だと登録できないこと' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include('コメントを入力してください')
      end
      it 'Userが紐付いてないと登録できないこと' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Userを入力してください')
      end
      it 'builderが紐付いてないと登録できないこと' do
        @comment.builder = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Builderを入力してください')
      end
    end
  end
end
