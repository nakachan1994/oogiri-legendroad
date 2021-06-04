class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :theme
  has_many :likes, dependent: :destroy

  validates :content, presence: true

  # userがLikesテーブル内に存在するか
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
