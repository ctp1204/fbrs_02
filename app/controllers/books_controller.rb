class BooksController < ApplicationController
  before_action :load_book, except: %i(index find new create)
  before_action :book_by_category, only: %i(show find)

  def index
    @books = Book.newest
    @bookNews = Book.newest.paginate page: params[:page],
      per_page: Settings.controllers.book.index_page
  end

  def show; end

  def find; end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @book.update(book_params)
      flash[:success] = t ".update"
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "deleted"
      redirect_to books_path
    else
      flash[:danger] = t "un_delete"
      redirect_to root_path
    end
  end

  private

  def book_params
    params.require(:book).permit :title, :content, :description, :author,
      :publisher, :rate_points, :number_pages, :category_id, :book_img
  end

  def load_book
    @book = Book.find_by_id params[:id]
    return if @book
    flash[:danger] = t "messenger"
    redirect_to books_path
  end

  def book_by_category
    @books = Book.by_category(params[:category]).limit Settings.models.limit
  end
end
