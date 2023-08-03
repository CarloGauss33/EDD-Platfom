FactoryBot.define do
  factory :course_information_module do
    course { create(:course) }
    name { "MyString" }
    position { 1 }
    visible { true }
  end
end
