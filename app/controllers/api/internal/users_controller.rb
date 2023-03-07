class Api::Internal::UsersController < Api::Internal::BaseController
  before_action :authenticate_user!

  def update
    respond_with user.update!(user_params)
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :names,
      :last_names,
      :university_id,
      :rut,
      :github_username,
      :password
    )
  end

  def user
    @user ||= current_user
  end
end
