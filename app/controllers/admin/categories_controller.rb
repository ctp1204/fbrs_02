class Admin::CategoriesController < ApplicationController
  layout "admin"
  before_action :logged_in_user
  before_action :is_admin, except: :destroy
  before_action :find_category, only: :destroy

  def index
    @categories = Category.sort_by_name.paginate page: params[:page],
     per_page: Settings.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "deleted"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "un_delete"
      redirect_to admin_root_path
    end
  end

  private

  def category_params
    params.require(:category).permit :name, :parent_id
  end

  def find_category
    @category = Category.find_by_id params[:id]
    return if @category
    flash[:danger] = t "fail"
    redirect_to admin_root_path
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
