class ReviewsController < ApplicationController
  before_action :logged_in_user, only: %i(new create edit update destroy)
  before_action :load_book
  before_action :build_review
  before_action :load_review, only: %i(edit update destroy)

  def new
    @review = Review.new
  end

  def create
    @review = @book.reviews.new(review_params)
    @review.user_id = current_user.id

    if @review.save
      flash[:success] = t "controller.reviews.create_review"
      redirect_to book_path(@book)
    else
      flash[:danger] = t "controller.reviews.create_review_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @review.update(review_params)
      flash[:success] = t "controller.reviews.update_review"
      redirect_to book_path(@book)
    else
      flash[:danger] = t "controller.reviews.update_review_fail"
      render :edit
    end
  end

  def destroy
    if @review.destroy
      flash[:success] = t "controller.reviews.delete_reivew"
      redirect_to book_path(@book)
    else
      flash[:danger] = t "controller.reviews.delete_review_fail"
      redirect_to root_path
    end
  end

  private

  def review_params
    params.require(:review).permit :rate, :content
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
    return if @book
    flash[:danger] = t "controller.no_data_book"
    redirect_to root_path
  end

  def load_review
    @review = Review.find_by id: params[:id]
    return if @review
    flash[:danger] = t "controller.no_data_review"
    redirect_to root_path
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "please_login"
    redirect_to login_path
  end

  def build_review
    @book_reivew = @book.reviews.build
  end
end
