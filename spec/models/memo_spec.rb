require 'rails_helper'

RSpec.describe Memo, type: :model do
  before do
    @memo = FactoryBot.build(:memo)
  end

  describe 'メモ投稿' do
    context 'メモを投稿できる' do
      it '必須項目が全て記入されていれば投稿ができる' do
        expect(@memo).to be_valid
      end
      it 'why_contentが空でも投稿できる' do
        @memo.why_content = ''
        expect(@memo).to be_valid
      end
      it 'who_contentが空でも投稿できる' do
        @memo.who_content = ''
        expect(@memo).to be_valid
      end
      it 'where_contentが空でも投稿できる' do
        @memo.where_content = ''
        expect(@memo).to be_valid
      end
    end
    context 'メモを投稿できない' do
      it 'title_historyが空である' do
        @memo.title_history = ''
        @memo.valid?
        expect(@memo.errors.full_messages).to include("Title history can't be blank")
      end
      it 'contentが空である' do
        @memo.content = ''
        @memo.valid?
        expect(@memo.errors.full_messages).to include("Content can't be blank")
      end
      it 'userが紐づいていない' do
        @memo.user = nil
        @memo.valid?
        expect(@memo.errors.full_messages).to include("User must exist")
      end
    end
  end
end
