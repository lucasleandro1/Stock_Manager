FactoryBot.define do
  factory :user do
    email { "exemplo@teste.com" }
    password { "password123" }
    password_confirmation { "password123" }
  end
end
