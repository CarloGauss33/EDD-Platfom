FactoryBot.define do
  factory :course_class_enrollment do
    course_class { create(:course_class) }
    email { Faker::Internet.email }
    rut { Faker::IDNumber.chilean_id }
    university_id { "123456789" }
    enrollment_id { "123456789" }
    full_name { "MyString" }
  end
end
