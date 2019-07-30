class Password
  attr_writer :password

  def self.encrypt(password)
    Argon2::Password.create(password)
  end

  def self.verify_password(password, secure_password)
    Argon2::Password.verify_password(password, secure_password)
  end
end
