class BackOffice::CourseClassPolicy < BackOffice::DefaultPolicy
  def load_enrollments?
    true
  end
end
