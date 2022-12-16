require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Factory' do
    it 'has a valid factory' do
      expect(create(:user)).to be_valid
    end
  end

  describe 'Validations' do
    it 'is invalid without mail' do
      expect(build(:user, email: nil)).not_to be_valid
    end
  end

  describe 'Methods' do
    describe '.full_name' do
      it 'returns the full name of the user' do
        user = create(:user, names: 'John Joe', last_names: 'Doe Dae')
        expect(user.full_name).to eq('John Joe Doe Dae')
      end
    end

    describe '.first_name' do
      it 'returns the first name of the user' do
        user = create(:user, names: 'John Joe')
        expect(user.first_name).to eq('John')
      end
    end
  end

  describe 'Associations' do
    it { is_expected.to have_many(:students) }
    it { is_expected.to have_many(:course_classes).through(:students) }
  end
end
