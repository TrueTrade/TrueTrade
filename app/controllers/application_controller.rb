class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 # before_action :authenticate_admin!
  before_action :authenticate_user! # Added by Laura for devise, to authenticate user 
# From: https://github.com/danweller18/devise/wiki/Adding-a-Username-to-the-User-&-Admin-model
# before_filter :authenticate_admin!
before_filter :configure_permitted_parameters, if: :devise_controller?    

protected    
def configure_permitted_parameters     
devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }     
devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email, :password, :remember_me) }   
devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:username, :email, :password, :password_confirmation, :current_password)} # Optional line from github
end
end
