require 'rails_helper'

def basic_pass
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}"
end

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context '新規登録ができるとき' do
    it '正しい情報を入力すると新規登録ができてトップページに遷移する' do
      # basic認証の実行
      basic_pass
      # トップページに遷移
      visit root_path
      # トップページに新規登録ボタンがあることを確認
      expect(page).to have_content('新規登録')
      # 新規登録ページに遷移
      visit new_user_registration_path
      # ユーザー情報を入力
      fill_in 'Nickname', with: @user.nickname
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がる
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      # トップページに遷移したことを確認
      expect(current_path).to eq(root_path)
      # ログアウトボタンが表示されていることを確認
      expect(page).to have_content('ログアウト')
      # ログイン・新規登録ボタンが表示されていないことを確認
      expect(page).to have_no_content('ログイン')
      expect(page).to have_no_content('新規登録')
    end
  end
  context '新規登録ができないとき' do
    it '誤った情報では新規登録ができずに新規登録ページに留まる' do
      # basic認証の実行
      basic_pass
      # トップページに遷移
      visit root_path
      # トップページに新規登録ボタンがあることを確認
      expect(page).to have_content('新規登録')
      # 新規登録ページに遷移
      visit new_user_registration_path
      # ユーザー情報を入力
      fill_in 'Nickname', with: ''
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      fill_in 'Password confirmation', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントが上がらない
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 新規登録ページから遷移しないことを確認
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインできる' do
    it '保存されているユーザーの情報と一致すればログインできる' do
      # basic認証の実行
      basic_pass
      # トップページに遷移
      visit root_path
      # ログインボタンがあることを確認
      expect(page).to have_content('ログイン')
      # ログインページに遷移
      visit new_user_session_path
      # 正しいユーザー情報を入力
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページに遷移したことを確認
      expect(current_path).to eq root_path
      # ログアウトボタンが表示されていることを確認
      expect(page).to have_content('ログアウト')
      # ログイン・新規登録ボタンが表示されていないことを確認
      expect(page).to have_no_content('ログイン')
      expect(page).to have_no_content('新規登録')
    end
  end

  context 'ログインできない' do
    it '保存されているユーザーの情報と一致しないとログインができない' do
      # basic認証の実行
      basic_pass
      # トップページに遷移
      visit root_path
      # ログインボタンがあることを確認
      expect(page).to have_content('ログイン')
      # ログインページに遷移
      visit new_user_session_path
      # 誤ったユーザー情報を入力
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページから遷移しないことを確認
      expect(current_path).to eq new_user_session_path
    end
  end
end
