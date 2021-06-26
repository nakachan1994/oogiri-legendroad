class Theme < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  attachment :image

  validates :content, length: {maximum: 50}
  validate :required_either_image_or_content

  # themeのstatusの判定
  def self.theme_status?
    where(status: true)
  end

  # 今月の回答数の多いお題
  def self.pick_up_themes
    Theme.includes(:user, :answers).find(Answer.group(:theme_id).where(created_at: Time.current.all_week).order(Arel.sql('count(theme_id) desc')).limit(6).pluck(:theme_id))
  end

  private
  # image.contentのどちらかの値があればtrue
  # image.contentどちらも入力されている場合や入力されていない場合は false
  def required_either_image_or_content
    return if image.present? ^ content.present?
    errors.add(:base, '画像または文字のどちらか一方で投稿可能です')
  end
end
