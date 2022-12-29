class FileUploader < BaseUploader
  ALLOWED_TYPES =  %w[
    image/jpeg
    image/jpg
    image/png
    application/pdf
    application/msword
  ].freeze

  MAX_SIZE = 256 * 1024 * 1024 # 256MB

  def allowed_types
    @allowed_types ||= ALLOWED_TYPES
  end

  Attacher.validate do
    validate_max_size MAX_SIZE
  end
end
