require 'rails_helper'

RSpec.describe CourseClass, type: :model do
  describe "Factory" do
    it "has a valid factory" do
      expect(create(:course_class)).to be_valid
    end
  end

  describe "Validations" do
    it 'validates uniqueness of section scoped to course_id' do
      course = create(:course)
      create(:course_class, course: course, section: 1)
      expect(build(:course_class, course: course, section: 1)).not_to be_valid
    end
  end

  describe "Associations" do
    it { is_expected.to belong_to(:course) }

    describe "has_many_through" do
      let(:course_class) { create(:course_class) }

      it "has many students" do
        create_list(:student, 3, course_class: course_class)

        expect(course_class.students.count).to eq(3)
      end
    end
  end
end
