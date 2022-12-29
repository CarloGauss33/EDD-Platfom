FactoryBot.define do
  factory :assignment do
    course { create(:course) }
    name { "Interrogacion 1" }
    description { "Interrogacion 1 de EDD" }
    start_date { Time.zone.now }
    end_date { Time.zone.now + 1.hour }
    kind { :exam }
    weight { 0.2 }
    status { :completed }
  end
end
