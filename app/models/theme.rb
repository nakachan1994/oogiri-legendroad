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

  private
  # image.contentのどちらかの値があればtrue
  # image.contentどちらも入力されている場合や入力されていない場合は false
  def required_either_image_or_content
    return if image.present? ^ content.present?
    errors.add(:base, '画像または文字のどちらか一方で投稿可能です')
  end
end
