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

# 称号の条件式
  def self.total_exp_title(total_exp)
    if total_exp < 10
      value = "ヒヨッコ"
    elsif total_exp < 100
      value = "新人"
    end
    value
  end
end
