require 'rails_helper'

RSpec.describe CourseInformationModule, type: :model do
  describe 'Factory' do
    it 'has a valid factory' do
      expect(build(:course_information_module)).to be_valid
    end
  end

  describe 'Relations' do
    it { is_expected.to belong_to(:course) }
    it { is_expected.to have_many(:course_information_contents) }
  end
end
