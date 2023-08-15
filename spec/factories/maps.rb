FactoryBot.define do
  factory :map do
    name      {"仮地名"}
    latitude  {35.753072}
    longitude {139.702148}
    user_id   {1}
  end
  factory :map2, class: Map do
    name      {"別の地名"}
    latitude  {35.753072}
    longitude {139.702148}
    user_id   {99}
  end
end