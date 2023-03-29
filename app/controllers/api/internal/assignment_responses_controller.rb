class Api::Internal::AssignmentResponsesController < Api::Internal::BaseController
  before_action :authenticate_user!

  def update
    assignment_response.submitted!
    respond_with assignment_response
  end

  private

  def assignment_response
    @assignment_response ||= AssignmentResponse.find_by!(id: params[:id])
  end
end
