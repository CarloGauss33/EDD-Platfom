require 'rails_helper'

describe AssignmentQuestionResponseObserver do
  def trigger(type, event, object)
    described_class.trigger(type, event, object)
  end

  describe 'after_save' do
    let(:assignment_question_response) { create(:assignment_question_response) }
    let(:assignment_response) { assignment_question_response.assignment_response }

    it 'updates the assignment response status' do
      expect(assignment_response).to be_pending
      trigger(:after, :save, assignment_question_response)
      expect(assignment_response.reload).to be_submitted
    end

    it 'does not update the assignment response status if it is not pending' do
      assignment_response.graded!
      expect(assignment_response).to be_graded
      trigger(:after, :save, assignment_question_response)
      expect(assignment_response.reload).to be_graded
    end
  end
end
