require 'rails_helper'

RSpec.describe NotifyInterrogationUploadJob, type: :job do
  describe 'perform' do
    let(:webhook_client) { instance_double(Automate::WebhookClient, post_payload: nil) }

    def perform
      described_class.perform_now(assignment_response_id)
    end

    before do
      allow(Automate::WebhookClient).to receive(:new).and_return(webhook_client)
    end

    context 'when assingment_response is invalid' do
      let(:assignment_response_id) { nil }

      it 'does not call webhook' do
        perform
        expect(webhook_client).not_to have_received(:post_payload)
      end
    end

    context 'when assignment_response is valid' do
      let(:assignment_response) { create(:assignment_response) }
      let(:assignment_response_id) { assignment_response.id }

      it 'calls webhook' do
        perform
        expect(webhook_client)
          .to have_received(:post_payload)
          .with(
            'email' => assignment_response.student_email,
            'assignment_title' => assignment_response.assignment_name,
            'date' => assignment_response.created_at.strftime('%m/%d/%Y %H:%M:%S')
          )
      end
    end

    context 'when webhook url is not set' do
      let(:assignment_response) { create(:assignment_response) }
      let(:assignment_response_id) { assignment_response.id }

      before do
        allow(Automate::WebhookClient).to receive(:new).and_return(nil)
      end

      it 'does not call webhook' do
        perform
        expect(webhook_client).not_to have_received(:post_payload)
      end
    end
  end
end
