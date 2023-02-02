require 'rails_helper'

RSpec.describe BackOffice::CourseClassPolicy, type: :policy do
  subject { described_class }

  permissions :load_enrollments? do
    it 'grants access to load_enrollments' do
      expect(described_class).to permit(nil)
    end
  end

  permissions :sync_students? do
    it 'grants access to sync_students' do
      expect(described_class).to permit(nil)
    end
  end
end
