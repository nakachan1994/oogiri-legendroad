class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :theme
  has_many :likes, dependent: :destroy

  validates :content, presence: true, length: {maximum: 50}

  # userがLikesテーブル内に存在するか
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
# answerのstatusの判定
  def self.answer_status?
    where(status: true)
  end
end
