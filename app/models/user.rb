class User < ApplicationRecord
  has_many :credentials

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, length: { in: 1..100 }
end
