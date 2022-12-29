FactoryBot.define do
  factory :assignment_response_document do
    assignment_response { create(:assignment_response) }
    score { 7.0 }
    description { "Interrogacion 1 de EDD" }
    file do
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec/fixtures/edd.png'),
        'image/png'
      )
    end
  end
end
