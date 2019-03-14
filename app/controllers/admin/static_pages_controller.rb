class Admin::StaticPagesController < ApplicationController
  layout "admin"
  before_action :logged_in_user, onely: :index
  before_action :admin_user, onely: :index

  def index; end

  private
  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "controller.book.please_login"
    redirect_to login_path
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
