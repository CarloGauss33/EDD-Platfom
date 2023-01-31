require 'rails_helper'

RSpec.describe BackOffice::CourseClassPolicy, type: :policy do
  subject { described_class }

  permissions :load_enrollments? do
    it 'grants access' do
      expect(described_class).to permit(nil)
    end
  end
end
