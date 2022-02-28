class Memo < ApplicationRecord
  belongs_to :user

  validates :title_history, :content, presence: true

  def self.search(search)
    if search != ""
      Mwmo.where('title_history LIKE(?)', 'why_content LIKE(?)', 'who_content LIKE(?)','where_content LIKE(?)','content LIKE(?)', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    else
      Memo.all
    end
  end
end
