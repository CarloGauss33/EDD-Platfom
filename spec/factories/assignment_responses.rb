FactoryBot.define do
  factory :assignment_response do
    assignment { create(:assignment) }
    student { create(:student) }
    status { :pending }
  end
end
