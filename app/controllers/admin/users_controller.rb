class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :is_admin, except: :destroy
  before_action :load_user, only: %i(update destroy)

  def index
    @users = User.sort_by_created_at.paginate page: params[:page],
      per_page: Settings.controllers.user.index_page_admin
    respond_to do |format|
      format.html
      format.csv {send_data @users.to_csv}
      format.xls {send_data @users.to_csv(col_sep: "\t")}
    end
  end

  def update
    if @user.admin?
      @user.user!
      flash[:success] = t "controller.user.setuser"
      redirect_to request.referrer
    elsif @user.user?
      @user.admin!
      flash[:success] = t "controller.user.setadmin"
      redirect_to request.referrer
    else
      flash[:danger] = t "controller.user.nofound"
      redirect_to request.referrer
    end
  rescue Exception
    flash[:notice] = t "controller.user.errors"
    redirect_to request.referrer
  end

  def destroy
    if @user.destroy
      flash[:success] = t "controller.user.delete_user"
      redirect_to admin_users_path
    else
      flash[:danger] = t "controller.user.delete_faild"
      redirect_to admin_root_path
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "controller.user.find_user_error"
    redirect_to root_path
  end

  def logged_in_user
    return if user_signed_in?
    store_location
    flash[:danger] = t "controller.book.please_login"
    redirect_to new_user_session_path
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
