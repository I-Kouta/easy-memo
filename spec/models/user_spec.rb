require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる' do
      it '必須項目が全て記入されていれば登録ができる' do
        #expect(@user).to be_valid
      end
      it 'パスワードが半角英数字混合で6文字以上なら登録ができる' do
        #@user.password = '111aaa'
        #@user.password_confirmation = '111aaa'
        #expect(@user).to be_valid
      end
    end
    context '新規登録できない' do
      it 'ニックネームが入力されていない' do
        #@user.nickname = ''
        #@user.valid?
        #expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが入力されていない' do
      end
      it 'emailが重複している' do
      end
      it 'emailが@を含んでいない' do
      end
      it 'passwordが入力されていない' do
      end
      it 'passwordが5文字以下である' do
      end
      it 'passwordがアルファベットのみである' do
      end
      it 'passwordが数字のみである' do
      end
      it 'passwordが全角文字を含んでいる' do
      end
      it 'passwordとpassword confirmationが一致しない' do
      end
    end
  end
end