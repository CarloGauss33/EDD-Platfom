class NotifyInterrogationUploadJob < ApplicationJob
  NOTIFICATION_WEBHOOK_URL = ENV.fetch('UPLOAD_NOTIFICATION_WEBHOOK_URL', nil)
  queue_as :default

  def perform(assignment_response_id)
    @assignment_response_id = assignment_response_id

    return if assignment_response.blank? || webhook_client.blank?

    webhook_client.post_payload(body)
  rescue
    Rails.logger.error("Failed to notify webhook")
  end

  private

  def body
    {
      'email' => assignment_response.student_email,
      'name' => assignment_response.user.names,
      'last_name' => assignment_response.user.last_names,
      'assignment_title' => assignment_response.assignment_name,
      'date' => assignment_response.created_at.strftime('%m/%d/%Y %H:%M:%S')
    }
  end

  def webhook_client
    @webhook_client ||= Automate::WebhookClient.new(NOTIFICATION_WEBHOOK_URL)
  end

  def assignment_response
    @assignment_response ||= AssignmentResponse.find_by(id: @assignment_response_id)
  end

  def formatted_created_at
    assignment_response.created_at.strftime('%m/%d/%Y %H:%M:%S')
  end
end
