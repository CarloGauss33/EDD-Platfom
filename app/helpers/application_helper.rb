module ApplicationHelper
  def default_course_student_registration_path
    new_course_student_path(current_course)
  end

  def oauth_enabled?
    ConfigVariable.fetch('OAUTH_ENABLED', false)
  end

  private

  def current_course
    @current_course ||= Course.current
  end
end
