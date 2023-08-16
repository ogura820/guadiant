FactoryBot.define do
  factory :user do
    email                 {"test@sample.com"}
    password              {"password"}
    password_confirmation {"password"}
    id                    {1}
  end
  factory :admin_user, class: User do
    email                 {"admintest@sample.com"}
    password              {"password"}
    password_confirmation {"password"}
    admin                 {true}
  end
  factory :id_user, class: User do
    email                 {"admintest@sample.com"}
    password              {"password"}
    password_confirmation {"password"}
    id                    {99}
  end
end