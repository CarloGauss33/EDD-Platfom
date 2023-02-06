FactoryBot.define do
  factory :course_class do
    course { create(:course) }
    section { 1 }
    canvas_course_id { "1" }
    professor_name { "Profesor" }
    professor_email { "professor@example.com" }
    default_inscription { false }
  end
end
