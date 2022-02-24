class Memo < ApplicationRecord
  belongs_to :user

  validates :title_history, :content, presence: true
end
