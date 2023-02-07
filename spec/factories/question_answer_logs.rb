FactoryBot.define do
  factory :question_answer_log do
    caller_platform { :telegram }
    caller_id { "MyString" }
    question { "MyText" }
    answer { "MyText" }
    answer_origin { :openai }
  end
end
