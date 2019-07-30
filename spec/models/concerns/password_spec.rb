require 'rails_helper'

RSpec.describe Password, type: :concern do
  let(:password) { "supersecret" }

  describe ".encrypt" do
    subject(:encrypt) { Password.encrypt(password) }
    it "encrypts a given string" do
      expect(encrypt).to_not equal(password)
    end
  end

  describe ".verify_password" do
    let(:secure_password) { Password.encrypt(password) }
    let(:bad_pass) { "notvalid" }

    it "returns true if the passwords match" do
      expect(Password.verify_password(password, secure_password)).to be true
    end

    it "returns false if the passwords don't match" do
      expect(Password.verify_password(bad_pass, secure_password)).to be false
    end
  end
end
