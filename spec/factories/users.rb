FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    names { Faker::Name.first_name }
    last_names { Faker::Name.last_name }
    status { :active }
    canvas_user_id { Faker::Number.number(digits: 10) }
    university_id { Faker::Number.number(digits: 10) }
    rut { Faker::Number.number(digits: 10) }
    github_username { Faker::Internet.username }
  end
end
