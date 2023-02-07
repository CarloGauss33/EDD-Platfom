require 'rails_helper'

RSpec.describe QuestionAnswerLog, type: :model do
  describe "Factory" do
    it "has a valid factory" do
      expect(create(:question_answer_log)).to be_valid
    end
  end

  describe "Enums" do
    it { is_expected.to define_enum_for(:caller_platform) }
    it { is_expected.to define_enum_for(:answer_origin).with_values(openai: 0, user: 1) }
  end
end
