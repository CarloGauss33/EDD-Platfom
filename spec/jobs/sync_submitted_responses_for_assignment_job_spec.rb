require 'rails_helper'

RSpec.describe SyncSubmittedResponsesForAssignmentJob, type: :job do
  describe '#perform' do
    def perform(assignment_id)
      described_class.perform_now(assignment_id)
    end

    context 'when there is no assignment' do
      it 'returns nil' do
        expect(perform(nil)).to be_nil
      end
    end

    context 'when there is no non-submitted responses' do
      let(:assignment) { create(:assignment) }

      it 'returns nil' do
        expect(perform(assignment.id)).to be_nil
      end
    end

    context 'when there is non-submitted responses' do
      let!(:assignment) { create(:assignment) }
      let!(:assignment_question) { create(:assignment_question, assignment: assignment) }
      let!(:inconsistent_assignment_response) do
        create(:assignment_response, assignment: assignment)
      end
      let!(:submitted_assignment_response) do
        create(:assignment_response, assignment: assignment, status: :submitted)
      end
      let!(:non_submitted_assignment_response) do
        create(:assignment_response, assignment: assignment)
      end

      before do
        create(:assignment_question_response,
               assignment_question: assignment_question,
               assignment_response: inconsistent_assignment_response,
               status: :submitted)

        perform(assignment.id)
      end

      it 'does not update status of non-submitted responses' do
        expect(non_submitted_assignment_response.reload).to be_pending
      end

      it 'does not update status of submitted responses' do
        expect(submitted_assignment_response.reload).to be_submitted
      end

      it 'updates status of inconsistent responses' do
        expect(inconsistent_assignment_response.reload).to be_submitted
      end
    end
  end
end
