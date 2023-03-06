module MailerHelper
  def application_host
    ENV.fetch('PRODUCTION_HOST', 'iic2133.org')
  end
end
