class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         # Twitter API認証用に追加
         :omniauthable, omniauth_providers: [:twitter]

  has_many :themes, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: {maximum: 11}
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
    like_count = Like.where(user_id: user.id).count
    total_exp = answer_like_count + theme_count + like_count
  end

  # 称号の条件式
  def self.total_exp_title(total_exp)
    if total_exp >= 2000
      value = "レジェンド"
    elsif total_exp >= 1500
      value = "マスター"
    elsif total_exp >= 1000
      value = "キング"
    elsif total_exp >= 700
      value = "四天王"
    elsif total_exp >= 400
      value = "賢者"
    elsif total_exp >= 250
      value = "名人"
    elsif total_exp >= 150
      value = "天狗"
    elsif total_exp >= 80
      value = "一人前"
    elsif total_exp >= 30
      value = "駆け出し"
    elsif total_exp >= 0
      value = "ヒヨッコ"
    end
  end

  # Twitter認証ログイン用
  # ユーザーの情報があれば探し、無ければ作成する
  def self.find_for_oauth(auth)
    user = User.find_by(uid: auth.uid, provider: auth.provider)

    user ||= User.create!(
      uid: auth.uid,
      provider: auth.provider,
      name: auth[:info][:name],
      email: User.dummy_email(auth),
      password: Devise.friendly_token[0, 20]
    )

    user
  end

  def self.dummy_email(auth)
    "#{Time.now.strftime('%Y%m%d%H%M%S').to_i}-#{auth.uid}-#{auth.provider}@example.com"
  end
end
