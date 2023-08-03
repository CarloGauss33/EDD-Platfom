class CourseInformationModule < ApplicationRecord
  belongs_to :course
  has_many :course_information_module_items, dependent: :destroy

  accepts_nested_attributes_for :course_information_module_items, allow_destroy: true
end

# == Schema Information
#
# Table name: course_information_modules
#
#  id          :bigint(8)        not null, primary key
#  course_id   :bigint(8)        not null
#  name        :string
#  description :text
#  position    :integer
#  visible     :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_course_information_modules_on_course_id  (course_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#
