class BackOffice::CourseClassPolicy < BackOffice::DefaultPolicy
  def load_enrollments?
    true
  end

  def sync_students?
    true
  end
end
