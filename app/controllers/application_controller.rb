class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  include ActionController::Cookies
  protect_from_forgery with: :null_session
  after_filter :set_csrf_cookie_for_ng

  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end
  # CSRF is turned off
  # skip_before_action :verify_authenticity_token
end
