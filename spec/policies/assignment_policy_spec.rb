require 'rails_helper'

RSpec.describe AssignmentPolicy, type: :policy do
  subject { described_class }

  let(:user) { User.new }

  permissions :show? do
    context 'when user and assignment are valid' do
      let!(:assignment) do
        create(:assignment,
               start_date: 1.day.ago,
               end_date: 1.day.from_now,
               status: :active)
      end

      it 'grants access' do
        expect(described_class).to permit(user, assignment)
      end
    end

    context 'when user and assignment are invalid' do
      let!(:assignment) { create(:assignment, status: :completed) }

      it 'denies access' do
        expect(described_class).not_to permit(user, assignment)
      end
    end

    context 'when user is invalid' do
      let!(:assignment) do
        create(:assignment,
               start_date: 1.day.ago,
               end_date: 1.day.from_now,
               status: :active)
      end

      it 'denies access' do
        expect(described_class).not_to permit(nil, assignment)
      end
    end
  end

  permissions :create? do
    context 'when user and assignment are valid' do
      let!(:assignment) do
        create(:assignment,
               start_date: 1.day.ago,
               end_date: 1.day.from_now,
               status: :active)
      end

      it 'grants access' do
        expect(described_class).to permit(user, assignment)
      end
    end

    context 'when user and assignment are invalid' do
      let!(:assignment) { create(:assignment, status: :completed) }

      it 'denies access' do
        expect(described_class).not_to permit(user, assignment)
      end
    end

    context 'when user is invalid' do
      let!(:assignment) do
        create(:assignment,
               start_date: 1.day.ago,
               end_date: 1.day.from_now,
               status: :active)
      end

      it 'denies access' do
        expect(described_class).not_to permit(nil, assignment)
      end
    end
  end

  permissions :update? do
    context 'when user and assignment are valid' do
      let!(:assignment) do
        create(:assignment,
               start_date: 1.day.ago,
               end_date: 1.day.from_now,
               status: :active)
      end

      it 'grants access' do
        expect(described_class).to permit(user, assignment)
      end
    end

    context 'when user and assignment are invalid' do
      let!(:assignment) { create(:assignment, status: :completed) }

      it 'denies access' do
        expect(described_class).not_to permit(user, assignment)
      end
    end

    context 'when user is invalid' do
      let!(:assignment) do
        create(:assignment,
               start_date: 1.day.ago,
               end_date: 1.day.from_now,
               status: :active)
      end

      it 'denies access' do
        expect(described_class).not_to permit(nil, assignment)
      end
    end
  end
end
