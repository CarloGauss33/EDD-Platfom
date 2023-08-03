require 'rails_helper'

RSpec.describe CourseInformationContent, type: :model do
  describe 'Factory' do
    it 'has a valid factory' do
      expect(build(:course_information_content)).to be_valid
    end
  end

  describe 'Relations' do
    it { is_expected.to belong_to(:course_information_module) }
  end
end
