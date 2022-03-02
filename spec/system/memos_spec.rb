require 'rails_helper'

def basic_pass
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}"
end

RSpec.describe "メモ投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  
  context 'メモが投稿できる' do
    it 'ログインしたユーザーはメモを投稿できる' do
      # basic認証の実行
      # ログインする
      # トップページに遷移していることを確認
      # メモ投稿へのボタンがあることを確認
      # メモ投稿ページへ移動
      # 内容を入力
      # Memoモデルのカウントが1上がることを確認
      # トップページに遷移することを確認
      # トップページに投稿したメモが存在していることを確認
    end
  end

  context 'メモが投稿できない' do
    it 'ログインしていないと投稿ページに遷移できない' do
      # basic認証の実行
      # トップページに遷移(ログインしていない)
      # メモ投稿へのボタンがないことを確認
    end
  end


end
