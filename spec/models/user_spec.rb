require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'email,password,password_confirmation,nickname,last_name,first_name,last_name_kana,first_name_kana,self_introductionが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが英数字混合の６文字以上だと登録できる' do
        @user.password = 'hogehoge11'
        @user.password_confirmation = 'hogehoge11'
        expect(@user).to be_valid
      end
      it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.last_name = '山田'
        @user.first_name = 'たろうタロウ'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスが入力されていません。")
      end
      it 'emailに@が存在しないと登録できない' do
        @user.email = 'hoge123.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは有効でありません。')
      end
      it 'emailが重複していると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('メールアドレスは既に使用されています。')
      end
      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードが入力されていません。")
      end
      it 'passwordが存在してもpasspwrd_confirmationが空だと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmationが内容とあっていません。")
      end
      it 'passwordが英字だけでは登録できない' do
        @user.password = 'hogehoge'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmationが内容とあっていません。", "パスワードは有効でありません。")
      end
      it 'passwordが数字だけでは登録できない' do
        @user.password = '12345678'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmationが内容とあっていません。", "パスワードは有効でありません。")
      end
      it 'passwordが全角では登録できない' do
        @user.password = 'ほげほげ１１'
        @user.password_confirmation = 'ほげほげ１１'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは有効でありません。')
      end
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームが入力されていません。")
      end
      it 'last_nameが空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字が入力されていません。", "苗字は有効でありません。")
      end
      it 'first_nameが空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前が入力されていません。", "名前は有効でありません。")
      end
      it 'last_name_kanaが空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ミョウジが入力されていません。", "ミョウジは有効でありません。")
      end
      it 'last_name_kanaがカタカナ以外だと登録できない' do
        @user.last_name_kana = 'ほげほげ'
        @user.valid?
        expect(@user.errors.full_messages).to include('ミョウジは有効でありません。')
      end
      it 'first_name_kanaが空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ナマエが入力されていません。", "ナマエは有効でありません。")
      end
      it 'first_name_kanaがカタカナ以外だと登録できない' do
        @user.first_name_kana = 'ほげほげ'
        @user.valid?
        expect(@user.errors.full_messages).to include('ナマエは有効でありません。')
      end
      it 'last_nameは、全角（漢字・ひらがな・カタカナ）以外の入力では登録できない' do
        @user.last_name = '12345@'
        @user.valid?
        expect(@user.errors.full_messages).to include('苗字は有効でありません。')
      end
      it 'first_nameは、全角（漢字・ひらがな・カタカナ）以外の入力では登録できない' do
        @user.first_name = '12345@'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は有効でありません。')
      end
      it 'self_introductionが空だと登録できない' do
        @user.self_introduction = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("自己紹介文が入力されていません。")
      end
    end
  end
end
