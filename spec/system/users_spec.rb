require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context '新規登録ができるとき' do
    it '正しい情報を入力すると新規登録ができてトップページに遷移する' do
      #トップページに遷移
      visit root_path
      #トップページに新規登録ボタンがあることを確認
      expect(page).to have_content("新規登録")
      #新規登録ページに遷移
      visit new_user_registration_path
      #ユーザー情報を入力
      fill_in 'Nickname', with: @user.nickname
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation
      #サインアップボタンを押すとユーザーモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      #トップページに遷移したことを確認
      expect(current_path).to eq(root_path)
      #ログアウトボタンが表示されていることを確認
      expect(page).to have_content('ログアウト')
      #ログイン・新規登録ボタンが表示されていないことを確認
      expect(page).to have_no_content('ログイン')
      expect(page).to have_no_content('新規登録')
    end
  end
  context '新規登録ができないとき' do
    it '誤った情報では新規登録ができずに新規登録ページに留まる' do
      #トップページに遷移
      #トップページに新規登録ボタンがあることを確認
      #新規登録ページに遷移
      #ユーザー情報を入力
      #サインアップボタンを押してもユーザーモデルのカウントが上がらない
      #新規登録ページに止まっていることを確認する
    end
  end
end
