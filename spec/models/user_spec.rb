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

  describe 'Callbacks' do
    describe '#after_create_commit' do
      describe '#enroll_on_default_course' do
        let!(:course_class) { create(:course_class, default_inscription: true) }
        let(:user) { build(:user) }

        it 'creates a student in the default course class' do
          expect { user.save }.to change { Student.count }.by(1)
        end

        it 'does not create a student if the user is already a student' do
          create(:student, user: user, course_class: course_class)
          expect { user.save }.not_to change { Student.count }.from(1)
        end
      end
    end
  end

  describe 'Methods' do
    describe '#self.by_provider_and_uid' do
      let!(:user) { create(:user) }
      let!(:provider) do
        OauthProvider.create(
          provider: 'google_oauth2',
          uid: '123456789',
          user: user
        )
      end

      it 'returns the user by provider and uid' do
        expect(
          described_class.by_provider_and_uid(provider.provider, provider.uid)
        ).to eq(user)
      end
    end

    describe '#self.create_from_provider_data' do
      let(:provider_data) do
        OmniAuth::AuthHash.new(
          provider: 'google_oauth2',
          uid: '123456789',
          info: {
            email: 'test@example.com',
            first_name: 'John',
            last_name: 'Doe'
          }
        )
      end

      it 'creates a user from provider data' do
        expect do
          described_class.create_from_provider_data(provider_data)
        end.to change { described_class.count }.by(1)
      end
    end

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

    describe '.username' do
      it 'returns the username of the user' do
        user = create(:user, email: 'test@example.com')

        expect(user.username).to eq('test')
      end
    end

    describe '.assignments' do
      let(:user) { create(:user) }
      let(:course_class) { create(:course_class) }
      let(:course) { course_class.course }
      let(:assignment) { create(:assignment, course: course) }

      before do
        create(:student, user: user, course_class: course_class)
      end

      it 'returns the assignments of the user' do
        expect(user.assignments).to include(assignment)
      end
    end
  end

  describe 'Associations' do
    it { is_expected.to have_many(:students) }
    it { is_expected.to have_many(:course_classes).through(:students) }
  end
end
