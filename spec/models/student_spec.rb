require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'Factory' do
    it 'has a valid factory' do
      expect(create(:student)).to be_valid
    end
  end

  describe 'Validations' do
    let(:user) { create(:user) }
    let(:course_class) { create(:course_class) }

    before do
      create(:student, user: user, course_class: course_class)
    end

    it 'validates uniqueness of user_id scoped to course_class_id' do
      expect(build(:student, user: user, course_class: course_class)).not_to be_valid
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:course_class) }
  end

  describe 'Enums' do
    it { is_expected.to define_enum_for(:status) }
  end
end
