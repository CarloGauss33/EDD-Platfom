require 'rails_helper'

RSpec.describe CodeHomework, type: :model do
  describe 'factory' do
    it 'is valid' do
      expect(build(:code_homework)).to be_valid
    end
  end

  describe 'methods' do
    let!(:active_homework) { create(:code_homework, end_date: 1.day.from_now) }
    let!(:inactive_homework) { create(:code_homework, end_date: 1.day.ago) }

    describe 'inactive' do
      it 'returns inactive homeworks' do
        expect(described_class.inactive).to eq([inactive_homework])
      end

      it 'does not return active homeworks' do
        expect(described_class.inactive).not_to include(active_homework)
      end
    end

    describe 'active' do
      it 'returns active homeworks' do
        expect(described_class.active).to eq([active_homework])
      end

      it 'does not return inactive homeworks' do
        expect(described_class.active).not_to include(inactive_homework)
      end
    end
  end
end
