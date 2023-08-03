FactoryBot.define do
  factory :course_information_content do
    course_information_module { create(:course_information_module) }
    content { "MyText" }
    position { 1 }
    visible { true }
  end
end
