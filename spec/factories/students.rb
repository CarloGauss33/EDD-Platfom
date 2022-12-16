FactoryBot.define do
  factory :student do
    user { create(:user) }
    course_class { create(:course_class) }
    status { :active }
    canvas_enrollment_id { Faker::Number.number(digits: 10) }
  end
end
