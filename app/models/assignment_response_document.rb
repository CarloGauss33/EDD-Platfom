class AssignmentResponseDocument < ApplicationRecord
  include FileUploader::Attachment.new(:file)

  belongs_to :assignment_response

  validates :file_data, presence: true

  def filename
    file['filename']
  end
end

# == Schema Information
#
# Table name: assignment_response_documents
#
#  id                     :bigint(8)        not null, primary key
#  assignment_response_id :bigint(8)        not null
#  score                  :float
#  description            :string
#  file_data              :jsonb
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_assignment_response_documents_on_assignment_response_id  (assignment_response_id)
#
# Foreign Keys
#
#  fk_rails_...  (assignment_response_id => assignment_responses.id)
#
