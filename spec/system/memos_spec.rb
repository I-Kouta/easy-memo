require 'rails_helper'

def basic_pass
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}"
end

RSpec.describe 'メモ投稿', type: :system do
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
      expect(page).to have_content('メモを投稿する')
      # メモ投稿ページへ移動
      visit new_memo_path
      # 内容を入力
      fill_in 'タイトル(必須)', with: @memo_title_history
      fill_in 'メモ内容(必須)', with: @memo_content
      # Memoモデルのカウントが1上がることを確認
      expect  do
        find('input[name="commit"]').click
      end.to change { Memo.count }.by(1)
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
      expect(page).to have_no_content('メモを投稿する')
    end
  end
end

RSpec.describe 'メモ編集', type: :system do
  before do
    @memo1 = FactoryBot.create(:memo)
    @memo2 = FactoryBot.create(:memo)
  end
  context 'メモ編集ができる' do
    it 'ログインしているユーザーは自身のメモの編集が可能' do
      # basic認証の実行
      basic_pass
      # メモ1を投稿したユーザーでログイン
      sign_in(@memo1.user)
      # メモ1の詳細/編集ボタンがあることを確認
      expect(page).to have_content('詳細/編集')
      # 編集ページへ遷移
      visit edit_memo_path(@memo1)
      # メモの内容がフォームに残っていることを確認
      expect(
        find('#memo_title_history').value
      ).to eq(@memo1.title_history)
      expect(
        find('#memo_why_content').value
      ).to eq(@memo1.why_content)
      expect(
        find('#memo_who_content').value
      ).to eq(@memo1.who_content)
      expect(
        find('#memo_where_content').value
      ).to eq(@memo1.where_content)
      expect(
        find('#memo_content').value
      ).to eq(@memo1.content)
      # 内容を編集
      fill_in 'memo_title_history', with: "#{@memo1.title_history}+編集したタイトル"
      fill_in 'memo_why_content', with: "#{@memo1.why_content}+編集したキッカケ"
      fill_in 'memo_who_content', with: "#{@memo1.who_content}+編集した人物"
      fill_in 'memo_where_content', with: "#{@memo1.where_content}+編集したシチュエーション"
      fill_in 'memo_content', with: "#{@memo1.content}+編集した内容"
      # 編集してもMemoモデルのカウントは変わらないことを確認
      expect  do
        find('input[name="commit"]').click
      end.to change { Memo.count }.by(0)
      # トップページに遷移
      expect(current_path).to eq(root_path)
      # トップページに変更した内容のメモ1のタイトルが存在していることを確認
      expect(page).to have_content("#{@memo1.title_history}+編集したタイトル")
    end
  end

  context 'メモ編集ができない' do
    it '自分以外のメモは編集ができない' do
      # basic認証の実行
      basic_pass
      # メモ1を投稿したユーザーでログイン
      sign_in(@memo1.user)
      # メモ2がビューに表示されていないことを確認
      expect(page).to have_no_content(@memo2.title_history.to_s)
    end
    it 'ログインしていないとメモ編集画面に遷移できない' do
      # basic認証の実行
      basic_pass
      # トップページに遷移(ログインしていない)
      visit root_path
      # メモ1が表示されていないことを確認
      # メモ2が表示されていないことを確認
      expect(page).to have_no_content(@memo1.to_s)
      expect(page).to have_no_content(@memo2.to_s)
    end
  end
end

RSpec.describe 'メモ削除', type: :system do
  before do
    @memo1 = FactoryBot.create(:memo)
    @memo2 = FactoryBot.create(:memo)
  end
  context 'メモが削除できる' do
    it 'ログインしているユーザーは自身のメモを削除できる' do
      # ダイアログ表示機能が反映されていないためコメントです
      # basic認証の実行
      # basic_pass
      # メモ1を投稿したユーザーでログイン
      # sign_in(@memo1.user)
      # メモ1に削除ボタンがあることを確認
      # expect(page).to have_link '内容の削除', href: memo_path(@memo1)
      # 削除するとレコードの数が1減ることを確認
      # expect{
      # find_link('内容の削除', href: memo_path(@memo1)).click
      # }.to change { Memo.count }.by(-1)
      # トップページに遷移
      # expect(current_path).to eq(root_path)
      # トップページにメモ1が存在していないことを確認
      # expect(page).to have_no_content("#{@memo1}")
    end
  end

  context 'メモが削除できない' do
    it 'ログインしても自分以外のメモは削除できない' do
      # basic認証の実行
      basic_pass
      # メモ2を投稿したユーザーでログイン
      sign_in(@memo2.user)
      # メモ1が表示されていないことを確認
      expect(page).to have_no_content(@memo1.to_s)
    end
    it 'ログインしていないとメモは削除できない' do
      # basic認証の実行
      basic_pass
      # トップページに遷移(ログインしていない)
      visit root_path
      # メモ1が表示されていないことを確認
      # メモ2が表示されていないことを確認
      expect(page).to have_no_content(@memo1.to_s)
      expect(page).to have_no_content(@memo2.to_s)
    end
  end
end
