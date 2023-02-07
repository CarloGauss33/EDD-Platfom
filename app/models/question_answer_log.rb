class QuestionAnswerLog < ApplicationRecord
  enum caller_platform: {
    telegram: 0,
    discord: 1,
    other: 2
  }

  enum answer_origin: {
    openai: 0,
    user: 1
  }
end

# == Schema Information
#
# Table name: question_answer_logs
#
#  id              :bigint(8)        not null, primary key
#  caller_platform :integer
#  caller_id       :string
#  question        :text
#  answer          :text
#  answer_origin   :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
