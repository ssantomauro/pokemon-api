FactoryBot.define do
  factory(:pokemon) do
    sequence(:name) { |n| "Name #{n}" }
    weight { rand(100) }
    height { rand(100) }
    sequence(:sprite_url) { |n| "http://example.com/PokeAPI/sprite_url_#{n}" }
  end
end
