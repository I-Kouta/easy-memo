class Memo < ApplicationRecord
  belongs_to :user

  validates :title_history, :content, presence: true

  def self.search(search)
    if search != ''
      Memo.where(
        'title_history LIKE(?) OR why_content LIKE(?) OR who_content LIKE(?) OR where_content LIKE(?) OR content LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"
      )
    else
      Memo.all
    end
  end
end
