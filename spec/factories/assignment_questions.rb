FactoryBot.define do
  factory :assignment_question do
    assignment
    question_type { 0 }
    title { "Pregunta 1" }
    description { "P1" }
  end
end
