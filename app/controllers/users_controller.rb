class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :load_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)
  before_action :load_follow, :load_unfollow, only: %i(following followers show)

  def index
    @users = User.sort_by_name.paginate page: params[:page],
      per_page: Settings.controllers.user.index_page
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = t "controller.user.create_user"
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "controller.user.update_profile"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "controller.user.delete_user"
      redirect_to users_path
    else
      flash[:danger] = t "controller.user.delete_faild"
      redirect_to root_path
    end
  end

  def following
    @title = t "controller.user.following"
    @users = @user.following.paginate page: params[:page],
      per_page: Settings.per_page
    render :show_follow
  end

  def followers
    @title = t "controller.user.followers"
    @users = @user.followers.paginate page: params[:page],
      per_page: Settings.per_page
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :phone,
      :address, :password, :password_confirmation, :role
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "controller.user.find_user_error"
    redirect_to root_path
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "controller.user.please_login"
    redirect_to login_path
  end

  def correct_user
    redirect_to root_path unless current_user?(@user)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def load_follow
    @follow = current_user.active_relationships.build
  end

  def load_unfollow
    @unfollow = current_user.active_relationships.find_by(followed_id: @user.id)
  end
end
