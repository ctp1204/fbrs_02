class LikesController < ApplicationController
  before_action :load_like, only: :destroy

  def create
    @like = current_user.likes.build likes_params
    if @like.save
      flash[:success] = t "controller.likes.like_success"
    else
      flash[:danger] = t "controller.likes.like_fail"
    end
    redirect_to @like.book
  end

  def destroy
    if @like.destroy
      flash[:success] = t "controller.likes.unlike_success"
    else
      flash[:danger] = t "controller.likes.unlike_fail"
    end
    redirect_to @like.book
  end

  private

  def likes_params
    params.require(:like).permit :book_id
  end

  def load_like
    @like = current_user.likes.find_by book_id: params[:book_id]
    return if @like
    flash[:danger] = t "controller.likes.load_like"
    redirect_to root_path
  end
end
