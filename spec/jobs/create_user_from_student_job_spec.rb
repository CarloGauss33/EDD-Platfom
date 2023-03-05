require 'rails_helper'

RSpec.describe CreateUserFromStudentJob, type: :job do
  let(:user_attributes) { attributes_for(:user) }
  let(:course_class) { create(:course_class) }

  describe '#perform' do
    def perform
      described_class.perform_now(user_attributes, course_class&.id)
    end

    context 'when course_class is not present' do
      let(:course_class) { nil }

      it 'does not create a user' do
        expect { perform }
          .not_to(change { User.count })
      end
    end

    context 'when user_attributes is not present' do
      let(:user_attributes) { nil }

      it 'does not create a user' do
        expect { perform }
          .not_to(change { User.count })
      end
    end

    context 'when user already exists' do
      let!(:user) { create(:user, email: user_attributes[:email]) }

      it 'does not create a user' do
        expect { perform }
          .not_to(change { User.count })
      end

      it 'creates a student' do
        expect { perform }
          .to(change { Student.count }.by(1))
      end
    end

    context 'when user does not exist' do
      it 'creates a user' do
        expect { perform }
          .to(change { User.count }.by(1))
      end

      it 'creates a student' do
        expect { perform }
          .to(change { Student.count }.by(1))
      end
    end
  end
end
