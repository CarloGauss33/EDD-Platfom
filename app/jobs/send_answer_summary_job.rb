class SendAnswerSummaryJob < ApplicationJob
  queue_as :default

  def perform(assignment_response_id)
    @assignment_response_id = assignment_response_id

    return if assignment_response.blank?

    message_builder.from(
      "EDD-Platform <no-reply@#{domain}>"
    )

    message_builder.add_recipient(:to, assignment_response.student_email)
    message_builder.set_subject(
      "[EDD] #{assignment_response.assignment_name} Entregada!"
    )
    message_builder.set_text_body(
      "Hola #{assignment_response.user.first_name},\n\n" \
      "Tu entrega de la interrogación #{assignment_response.assignment_name} " \
      "ha sido recibida correctamente. Se adjunta una copia de las respuestas\n\n" \
      "Cualquier duda puedes dirigirla a cparedesr@uc.cl" \
    )

    assignment_response.assignment_question_responses.each do |response|
      message_builder.add_attachment(
        response.file.download,
        response.file.original_filename
      )
    end

    mailer.send_message(domain, message_builder)
  end

  private

  def assignment_response
    @assignment_response ||= AssignmentResponse.find_by(id: @assignment_response_id)
  end

  def domain
    @domain ||= ENV['MAILGUN_DOMAIN']
  end

  def mailer
    @mailer ||= Mailgun::Client.new
  end

  def message_builder
    @message_builder ||= Mailgun::MessageBuilder.new
  end
end
