class Contact < ApplicationRecord
  validates :name, presence: true, length: {maximum: 20}
  validates :email, presence: true
  validates :content, presence: true
end
