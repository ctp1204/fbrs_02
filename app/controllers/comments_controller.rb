class CommentsController < ApplicationController
  before_action :logged_in_user, except: %i(destroy)
  before_action :load_book
  before_action :load_review
  before_action :load_comment, except: %i(new create)

  def new
    @comment = Comment.new
  end

  def create
    @comment = @review.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html{ redirect_to request.referrer }
        format.js
      end
    else
      flash[:danger] = t "controller.comments.create_comment_fail"
      render :new
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.html{ redirect_to request.referrer }
        format.js
      end
    else
      flash[:danger] = t "controller.comments.delete_comment_fail"
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
    return if @book
    flash[:danger] = t "controller.no_data_book"
    redirect_to root_path
  end

  def load_review
    @review = Review.find_by id: params[:review_id]
    return if @review
    flash[:danger] = t "controller.no_data_review"
    redirect_to root_path
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
    flash[:danger] = t "controller.no_data_comment"
    redirect_to root_path
  end

  def logged_in_user
    return if user_signed_in?
    store_location
    flash[:danger] = t "please_login"
    redirect_to new_user_session_path
  end
end
