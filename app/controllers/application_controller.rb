class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  include SessionsHelper
  include BooksHelper

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :address, :picture]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def logged_in_user
    return if user_signed_in?
    store_location
    flash[:danger] = t "controller.book.please_login"
    redirect_to new_user_session_path
  end

  def is_admin
    redirect_to(root_path) unless current_user.admin?
    flash[:danger] = t "controller.book.error_page"
  end
end
