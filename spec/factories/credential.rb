FactoryBot.define do
  factory :credential do
    user
    email { "george@jungle.com" }
    password { "supersekret" }
    password_confirmation { "supersekret" }
  end
end
