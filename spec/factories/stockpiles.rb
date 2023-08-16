FactoryBot.define do
  factory :stockpile do
    name      {"トランプ"}
    user_id   {1}
  end
  factory :stockpile2, class: Stockpile do
    name      {"ビデオゲーム"}
    user_id   {99}
  end
end