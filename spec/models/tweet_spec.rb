require 'rails_helper'
RSpec.describe Tweet, type: :model do
  before do
    @tweet = FactoryBot.build(:tweet)
  end

  describe '新規登録' do
    context '新規投稿できるとき' do
      it 'textが存在すれば登録できる' do
        expect(@tweet).to be_valid
      end
    end
    context '新規投稿できないとき' do
      it 'textが空だと登録できない' do
        @tweet.text = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include('Textが入力されていません。')
      end
    end
  end
end
