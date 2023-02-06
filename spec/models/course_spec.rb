require 'rails_helper'

RSpec.describe Course, type: :model do
  describe "Factory" do
    it "has a valid factory" do
      expect(create(:course)).to be_valid
    end
  end

  describe "Validations" do
    describe ".active_course_unique?" do
      context "when there is an active course" do
        before { create(:course, status: :active) }

        it "is invalid" do
          expect(build(:course, status: :active)).not_to be_valid
        end
      end

      context "when there is no active course" do
        it "is valid" do
          expect(build(:course, status: :active)).to be_valid
        end
      end

      context "when there is an inactive course" do
        before { create(:course, status: :inactive) }

        it "is valid" do
          expect(build(:course, status: :inactive)).to be_valid
        end
      end
    end

    describe ".present?" do
      it "is invalid without a name" do
        expect(build(:course, name: nil)).not_to be_valid
      end

      it "is invalid without a code" do
        expect(build(:course, code: nil)).not_to be_valid
      end

      it "is invalid without a year" do
        expect(build(:course, year: nil)).not_to be_valid
      end
    end

    describe ".year" do
      it "is invalid with a year less than 2016" do
        expect(build(:course, year: 2015)).not_to be_valid
      end

      it "is invalid with a year greater than 2100" do
        expect(build(:course, year: 2101)).not_to be_valid
      end
    end
  end

  describe "Enums" do
    it { is_expected.to define_enum_for(:status).with_values(active: 0, inactive: 1) }
    it { is_expected.to define_enum_for(:season).with_values(first_semester: 0, second_semester: 1) }
  end

  describe "Methods" do
    describe ".current" do
      let!(:active_course) { create(:course, status: :active) }
      let!(:inactive_courses) { create_list(:course, 3, status: :inactive) }

      it "returns the active course" do
        expect(described_class.current).to eq(active_course)
      end
    end

    describe ".summary" do
      let!(:course) { create(:course) }
      let(:assignments) { create_list(:assignment, 3, course: course) }

      it "returns a summary of the course" do
        expect(course.summary).to be_a(String)
      end

      it "returns a summary of the course's assignments" do
        expect(course.summary).to include("Actividades:")
      end
    end
  end
end
