FactoryBot.define do
  factory :assignment do
    course { create(:course) }
    name { "Interrogacion 1" }
    description { "Interrogacion 1 de EDD" }
    start_date { 1.day.ago }
    end_date { 1.day.from_now }
    kind { :exam }
    weight { 0.2 }
    status { :active }
  end
end
