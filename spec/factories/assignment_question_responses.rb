FactoryBot.define do
  factory :assignment_question_response do
    assignment_question { create(:assignment_question) }
    assignment_response { create(:assignment_response) }
    status { :pending }
    file do
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec/fixtures/edd.png'),
        'image/png'
      )
    end
  end
end
