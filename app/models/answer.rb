class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :theme
  has_many :likes, dependent: :destroy

  validates :content, presence: true
end
