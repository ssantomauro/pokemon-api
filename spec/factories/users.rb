FactoryBot.define do
  factory(:user) do
    sequence(:email) { |n| "email#{n}@example.com" }
    encrypted_password { 'password' }
    sequence(:jti) { |n| "jti_#{n}" }
  end
end
