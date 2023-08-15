FactoryBot.define do
  factory :user do
    email                 {"test@sample.com"}
    password              {"111111"}
    password_confirmation {"111111"}
  end
  factory :admin_user do
    email                 {"admintest@sample.com"}
    password              {"111111"}
    password_confirmation {"111111"}
    admin                 {true}
  end
end