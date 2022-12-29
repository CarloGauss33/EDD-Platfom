FactoryBot.define do
  factory :assignment_response do
    assignment { create(:assignment) }
    student { create(:student) }
    status { :submitted }
    final_score { 7.0 }
  end
end
