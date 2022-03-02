require 'rails_helper'

def basic_pass
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}"
end

RSpec.describe "メモ投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @memo_title_history = Faker::Lorem.sentence
    @memo_content = Faker::Lorem.sentence
  end
  
  context 'メモが投稿できる' do
    it 'ログインしたユーザーはメモを投稿できる' do
      # basic認証の実行
      basic_pass
      # ログインする
      sign_in(@user)
      # トップページに遷移していることを確認
      expect(current_path).to eq(root_path)
      # メモ投稿へのボタンがあることを確認
      expect(page).to have_content('メモを投稿しましょう')
      # メモ投稿ページへ移動
      visit new_memo_path
      # 内容を入力
      fill_in 'タイトル(必須)', with: @memo_title_history
      fill_in 'メモ内容(必須)', with: @memo_content
      # Memoモデルのカウントが1上がることを確認
      expect{
        find('input[name="commit"]').click
      }.to change { Memo.count }.by(1)
      # トップページに遷移することを確認
      expect(current_path).to eq(root_path)
      # トップページに投稿したメモが存在していることを確認
      expect(page).to have_content(@memo_title_history)
    end
  end

  context 'メモが投稿できない' do
    it 'ログインしていないと投稿ページに遷移できない' do
      # basic認証の実行
      basic_pass
      # トップページに遷移(ログインしていない)
      visit root_path
      # メモ投稿へのボタンがないことを確認
      expect(page).to have_no_content('メモを投稿しましょう')
    end
  end
end

RSpec.describe "メモ編集", type: :system do
  before do
    @memo1 = FactoryBot.create(:memo)
    @memo2 = FactoryBot.create(:memo)
  end
  context 'メモ編集ができる' do
    it 'ログインしているユーザーは自身のメモの編集が可能' do
      # メモ1を投稿したユーザーでログイン
      # メモ1に編集画面へのリンクがあることを確認
      # 編集ページへ遷移
      # メモの内容がフォームに残っていることを確認
      # 内容を編集
      # 編集してもMemoモデルのカウントは変わらないことを確認
      # トップページに遷移
      # トップページに変更した内容のメモ1のタイトルが存在していることを確認
    end
  end
  
  context 'メモ編集ができない' do
    it '自分以外のメモは編集ができない' do
      # メモ1を投稿したユーザーでログイン
      # メモ2がビューに表示されていないことを確認
    end
    it 'ログインしていないとメモ編集画面に遷移できない' do
      # トップページに遷移(ログインしていない)
      # メモ1が表示されていないことを確認
      # メモ2が表示されていないことを確認
    end
  end
end