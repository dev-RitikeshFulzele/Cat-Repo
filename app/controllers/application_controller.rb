class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers
  helper_method :user_signed_in?, :current_user
  allow_browser versions: :modern
end
