FactoryBot.define do
  factory(:type) do
    sequence(:id) { |n| "type_#{n}" }
    name { id }
  end
end
