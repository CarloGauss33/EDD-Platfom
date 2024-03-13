class CodeHomework < ApplicationRecord
  belongs_to :course
  has_many :code_homework_runs, dependent: :destroy

  scope :inactive, -> { where('end_date < ?', Time.zone.now) }
  scope :active, -> { where('end_date >= ?', Time.zone.now) }

  def self.current
    active.order(:end_date).first
  end
end

# == Schema Information
#
# Table name: code_homeworks
#
#  id                      :bigint(8)        not null, primary key
#  course_id               :bigint(8)        not null
#  name                    :string
#  homework_url            :string
#  start_date              :datetime
#  end_date                :datetime
#  repository_prefix       :string
#  template_repository_url :string
#  solution_repository_url :string
#  testcases_url           :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_code_homeworks_on_course_id  (course_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#
