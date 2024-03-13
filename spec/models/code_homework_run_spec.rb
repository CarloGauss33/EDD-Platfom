require 'rails_helper'

RSpec.describe CodeHomeworkRun, type: :model do
  describe 'Factory' do
    it 'have valid Factory' do
      expect(create(:code_homework_run)).to be_valid
    end
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:code_homework) }
    it { is_expected.to belong_to(:student) }
  end

  describe 'Enums' do
    it { is_expected.to define_enum_for(:status) }
  end

  describe 'Methods' do
    describe '.by_student' do
      let(:student) { create(:student) }
      let!(:code_homework_run) { create(:code_homework_run, student: student) }
      let!(:other_code_homework_run) { create(:code_homework_run) }

      it 'return code_homework_run' do
        expect(described_class.by_student(student.id)).to eq([code_homework_run])
      end
    end

    describe '.last_student_run' do
      let(:student) { create(:student) }
      let!(:code_homework_run) do
        create(:code_homework_run, student: student, created_at: 1.day.ago)
      end
      let!(:other_code_homework_run) do
        create(:code_homework_run, student: student, created_at: 1.year.ago)
      end

      it 'return last_student_run' do
        expect(described_class.last_student_run(student)).to eq(code_homework_run)
      end
    end

    describe '.student_able_to_run?' do
      let!(:student) { create(:student) }

      context 'when last_run is nil' do
        it 'return true' do
          expect(described_class.student_able_to_run?(student)).to eq(true)
        end
      end

      context 'when last_run is before TIMEOUT_BETWEEN_RUNS' do
        let!(:code_homework_run) do
          create(:code_homework_run, student: student, created_at: 4.minutes.ago)
        end

        it 'return false' do
          expect(described_class.student_able_to_run?(student)).to eq(false)
        end
      end

      context 'when last_run is after TIMEOUT_BETWEEN_RUNS' do
        let!(:code_homework_run) do
          create(:code_homework_run, student: student, created_at: 6.minutes.ago)
        end

        it 'return true' do
          expect(described_class.student_able_to_run?(student)).to eq(true)
        end
      end
    end
  end
end
