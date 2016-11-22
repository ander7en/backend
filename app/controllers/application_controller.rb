class ApplicationController < ActionController::API
  # include ActionController::RequestForgeryProtection
  # include ActionController::Cookies
  # protect_from_forgery with: :exception
  # after_action :set_csrf_cookie_for_ng
  #
  # protected
  #
  # def verified_request?
  #   super || valid_authenticity_token?(session, cookies['XSRF-TOKEN'])
  # end
  #
  # def set_csrf_cookie_for_ng
  #   cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  # end
  # CSRF is turned off
  # skip_before_action :verify_authenticity_token
end
