require 'rails_helper'

RSpec.describe AssignmentQuestion, type: :model do
  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:assignment_question)).to be_valid
    end
  end

  describe 'Associations' do
    it { should belong_to(:assignment) }
  end
end
