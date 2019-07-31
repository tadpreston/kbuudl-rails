class Credential < ApplicationRecord
  attr_accessor :password, :password_confirmation

  MAX_PASSWORD_LENGTH = 72

  belongs_to :user

  validates :email, presence: true
  validates :password, length: { maximum: MAX_PASSWORD_LENGTH }
  validates :password, confirmation: true
  validate do |record|
    record.errors.add(:password, :blank) unless record.password_digest.present?
  end

  def password=(unencrypted_password)
    if unencrypted_password.blank?
      self.password_digest = nil
    elsif unencrypted_password
      @password = unencrypted_password
      self.password_digest = hasher.create(unencrypted_password)
    end
  end

  def password_confirmation=(unencrypted_password)
    @password_confirmation = unencrypted_password
  end

  def authenticate(unencrypted_password)
    Argon2::Password.verify_password(unencrypted_password, password_digest) && self
  end

  private

  def password_digest?
    password_digest
  end

  def hasher
    Argon2::Password.new(t_cost: 2, m_cost: 16)
  end
end
