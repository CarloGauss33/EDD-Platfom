class Course < ApplicationRecord
  has_many :course_classes, dependent: :destroy
  has_many :assignments, dependent: :destroy

  validates :name, presence: true
  validates :code, presence: true
  validates :year,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than: 2015,
              less_than: 2100
            }

  validate :active_course_unique?

  enum status: {
    active: 0,
    inactive: 1
  }

  enum season: {
    first_semester: 0,
    second_semester: 1,
  }

  def self.current
    active.first
  end

  private

  def active_course_unique?
    if active? && Course.active.any?
      errors.add(:status, "There can only be one active course")
    end
  end
end

# == Schema Information
#
# Table name: courses
#
#  id                  :bigint(8)        not null, primary key
#  name                :string
#  code                :string
#  description         :string
#  status              :integer          default("active")
#  season              :integer          default("first_semester")
#  year                :integer          default(2023)
#  administrator_email :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
