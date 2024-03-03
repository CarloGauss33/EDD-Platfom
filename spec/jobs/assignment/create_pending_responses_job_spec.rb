require 'rails_helper'

RSpec.describe Assignment::CreatePendingResponsesJob, type: :job do
  def perform
    described_class.perform_now(assignment: assignment)
  end

  let(:course) { create(:course) }
  let(:course_class) { create(:course_class, course: course) }
  let(:status) { :pending }
  let(:assignment) { create(:assignment, course: course, status: status) }
  let!(:students) { create_list(:student, 3, course_class: course_class) }

  context 'when the assignment is not completed' do
    it 'creates an assignment response for each student' do
      expect { perform }.to change { AssignmentResponse.count }.by(3)
    end
  end

  context 'when the assignment is nil' do
    let(:assignment) { nil }

    it 'does not create any assignment responses' do
      expect { perform }.not_to (change { AssignmentResponse.count })
    end
  end
end
