class BackOffice::AssignmentPolicy < BackOffice::DefaultPolicy
  def sync_submitted_responses?
    true
  end
end
