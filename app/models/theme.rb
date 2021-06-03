class Theme < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :content, length: {minimum: 1, maximum: 100}

  attachment :image
end
