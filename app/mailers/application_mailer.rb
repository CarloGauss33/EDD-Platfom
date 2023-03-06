class ApplicationMailer < ActionMailer::Base
  helper :mailer
  default from: ENV.fetch('DEFAULT_EMAIL_FROM', '')
  default cco: ENV.fetch('DEFAULT_EMAIL_CC_RECIPIENTS', '').split(',')
  layout 'mailer'
end
