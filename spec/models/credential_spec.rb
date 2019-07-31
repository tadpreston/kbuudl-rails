require 'rails_helper'

RSpec.describe Credential, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:password).is_at_most(Credential::MAX_PASSWORD_LENGTH) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
  end



  describe ".password=" do
    subject(:credential) { build(:credential, password: password) }

    context "password is not blank" do
      let(:password) { "supersekret" }
      it "sets the password_digest" do
        expect(credential.password_digest).to_not be_nil
      end
      it "encrypts the password" do
        expect(credential.password_digest).to_not eq(password)
      end
    end
    context "password is blank" do
      let(:password) { "" }
      it "sets the password_digest to nil" do
        expect(credential.password_digest).to be_nil
      end
    end
    context "password is nil" do
      let(:password) { nil }
      it "does nothing" do
        expect(credential.password_digest).to be_nil
      end
    end
  end

  describe ".authenticate" do
    let(:password) { "supersekret" }
    subject(:credential) { create(:credential, password: password, password_confirmation: password) }

    context "with a valid password" do
      it "returns true" do
        expect(credential.authenticate(password)).to eq(credential)
      end
    end
    context "with an invalid password" do
      let(:invalid_password) { "invalid" }
      it "returns true" do
        expect(credential.authenticate(invalid_password)).to eq(false)
      end
    end
  end
end
