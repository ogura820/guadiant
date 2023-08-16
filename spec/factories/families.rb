FactoryBot.define do
  factory :family do
    name      {"長男"}
    age       {15}
    user_id   {1}
  end
  factory :family2, class: Family do
    name      {"次女"}
    age       {1}
    user_id   {99}
  end
end