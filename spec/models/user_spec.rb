require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる' do
      it '必須項目が全て記入されていれば登録ができる' do
        expect(@user).to be_valid
      end
      it 'パスワードが半角英数字混合で6文字以上なら登録ができる' do
        @user.password = '111aaa'
        @user.password_confirmation = '111aaa'
        expect(@user).to be_valid
      end
    end
    context '新規登録できない' do
      it 'ニックネームが入力されていない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが入力されていない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'emailが重複している' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailが@を含んでいない' do
        @user.email = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが入力されていない' do
        @user.password = ''
        @user.password_confirmation = '111aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが5文字以下である' do
        @user.password = '11aaa'
        @user.password_confirmation = '11aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordがアルファベットのみである' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードが無効です。英数字どちらも入力してください')
      end
      it 'passwordが数字のみである' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードが無効です。英数字どちらも入力してください')
      end
      it 'passwordが全角文字を含んでいる' do
        @user.password = '1a２３４５６７'
        @user.password_confirmation = '1a２３４５６７'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードが無効です。英数字どちらも入力してください')
      end
      it 'passwordとpassword confirmationが一致しない' do
        @user.password = '111aaa'
        @user.password_confirmation = '211aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
    end
  end
end
