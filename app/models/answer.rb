class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :theme
  has_many :likes, dependent: :destroy

  validates :content, presence: true, length: { maximum: 50 }

  # userがLikesテーブル内に存在するか
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  # answerのstatusの判定
  def self.answer_status?
    where(status: true)
  end

  # いいね順の回答(通算)
  def self.many_likes_answers
    Answer.find(Like.group(:answer_id).order('count(answer_id) desc').limit(3).pluck(:answer_id))
  end

  # いいね順の回答(週間）
  def self.pick_up_answers
    Answer.includes(:user, :theme, :likes).find(Like.group(:answer_id).where(created_at: Time.current.all_week).order(Arel.sql('count(answer_id) desc')).limit(3).pluck(:answer_id))
  end
end
