class CreateUserFromStudentJob < ApplicationJob
  queue_as :default

  def perform(user_attributes, course_class_id)
    @user_attributes = user_attributes
    @course_class_id = course_class_id

    return if course_class.nil? || @user_attributes.nil?

    user = find_or_create_user
    course_class.students.find_or_create_by(user: user)

    user
  end

  private

  def course_class
    @course_class ||= CourseClass.find_by(id: @course_class_id)
  end

  def generated_password
    @user_attributes[:university_id] || Devise.friendly_token[0, 20]
  end

  def find_or_create_user
    user = User.find_by(email: @user_attributes[:email])

    if user.nil?
      user = User.create!(
        @user_attributes.merge(
          password: generated_password
        )
      )
    end

    user
  end
end
