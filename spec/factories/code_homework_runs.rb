FactoryBot.define do
  factory :code_homework_run do
    code_homework
    student
    status { 0 }
    submitted_at { Faker::Date.between(from: 1.year.ago, to: 1.year.from_now) }
    graded_at { Faker::Date.between(from: 1.year.from_now, to: 2.years.from_now) }
    run_results { { "key" => "value" } }
  end
end
