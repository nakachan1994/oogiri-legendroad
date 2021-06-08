class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 has_many :themes, dependent: :destroy
 has_many :answers, dependent: :destroy
 has_many :likes, dependent: :destroy

 validates :name, presence: true, uniqueness: true, length: {maximum: 20}
 validates :email, presence: true, uniqueness: true

 attachment :profile_image

# 退会済みuserか確認
def active_for_authentication?
  super && (self.status == true)
end

# userのanswerに対するいいね数
def self.answer_like_count(user)
  answer_like_count = Like.where(answer_id: Answer.where(user_id: user.id).pluck(:id)).count
end
# userの経験値計算
def self.total_exp(user)
  answer_like_count = Like.where(answer_id: Answer.where(user_id: user.id).pluck(:id)).count * 10
  theme_count = Theme.where(user_id: user.id, status: true).count * 10
  total_exp = answer_like_count + theme_count
end
# 称号の条件式
  def self.total_exp_title(total_exp)
    if total_exp >= 100000
      value = "レジェンド"
    elsif total_exp >= 5000
      value = "マスター"
    elsif total_exp >= 2500
      value = "キング"
    elsif total_exp >= 1200
      value = "四天王"
    elsif total_exp >= 500
      value = "賢者"
    elsif total_exp >= 250
      value = "名人"
    elsif total_exp >= 180
      value = "天狗"
    elsif total_exp >= 100
      value = "一人前"
    elsif total_exp >= 30
      value = "駆け出し"
    elsif total_exp >= 0
      value = "ヒヨッコ"
    end
  end
end
