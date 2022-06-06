FactoryBot.define do
  factory(:user) do
    sequence(:email) { |n| "email#{n}@example.com" }
    encrypted_password { 'password' }
    sequence(:jti) { |n| "jti_#{n}" }
    role { 'user' }

    trait :admin do
      role { 'admin' }
    end
  end
end
