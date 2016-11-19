class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  protect_from_forgery with: :null_session

  # CSRF is turned off
  skip_before_action :verify_authenticity_token
end
