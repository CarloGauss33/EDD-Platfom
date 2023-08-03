class CourseInformationContent < ApplicationRecord
  belongs_to :course_information_module
end

# == Schema Information
#
# Table name: course_information_contents
#
#  id                           :bigint(8)        not null, primary key
#  course_information_module_id :bigint(8)        not null
#  name                         :string
#  description                  :text
#  position                     :integer
#  visible                      :boolean          default(TRUE)
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
# Indexes
#
#  index_course_information_contents_on_module_id  (course_information_module_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_information_module_id => course_information_modules.id)
#
