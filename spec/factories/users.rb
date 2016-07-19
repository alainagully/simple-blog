FactoryGirl.define do
  factory :user do
    first_name "MyString"
    last_name "MyString"
    sequence(:email) {|n| Faker::Internet.email.gsub("@", "-#{n}@")}
    password_digest "MyString"
  end
end
