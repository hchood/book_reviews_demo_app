FactoryGirl.define do
  factory :user do
    first_name "Gene"
    last_name "Parmesan"
    sequence(:email) { |n| "#{n}geneparmesan@privateinvestigatorsrus.com" }
    password "abcd12345"
  end
end
