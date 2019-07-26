require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it do
      should validate_presence_of(:first_name)
      should validate_presence_of(:last_name)
      should validate_presence_of(:username)
      should validate_length_of(:username).is_at_least(1).is_at_most(100)
    end
  end
end
