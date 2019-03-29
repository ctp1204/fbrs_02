class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  include SessionsHelper
  include BooksHelper
  include ApplicationHelper
  include CanCan::ControllerAdditions

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = t ".pls_login"
    redirect_to new_user_session_path
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :address, :picture]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def require_log_in
    unless user_signed_in?
      flash[:danger] = t "controller.book.please_login"
      redirect_to new_user_session_path
    end
  end
end
