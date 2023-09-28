class AssignmentResponseMailer < ApplicationMailer
  def notify_user_response(assignment_response)
    @assignment_response = assignment_response
    @user = assignment_response.user

    return if assignment_response.blank?

    assignment_response.assignment_question_responses.each do |response|
      attachments[response.file.original_filename] = response.file.read
    end

    mail(
      to: @user.email,
      subject: "[EDD] #{assignment_response.assignment_name} Entregada!"
    )
  end
end
