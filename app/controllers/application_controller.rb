class ApplicationController < ActionController::Base
  include PowerTypes::Presentable
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  protect_from_forgery prepend: true, unless: -> { request.format.json? }
  respond_to :html, :json

  private

  def not_authorized
    redirect_back(fallback_location: root_path)
  end
end
