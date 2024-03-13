FactoryBot.define do
  factory :code_homework do
    course
    name { Faker::Lorem.sentence }
    homework_url { Faker::Internet.url }
    start_date { Faker::Date.between(from: 1.year.ago, to: 1.year.from_now) }
    end_date { Faker::Date.between(from: 1.year.from_now, to: 2.years.from_now) }
    repository_prefix { Faker::Lorem.word }
    template_repository_url { Faker::Internet.url }
    solution_repository_url { Faker::Internet.url }
    testcases_url { Faker::Internet.url }
  end
end
