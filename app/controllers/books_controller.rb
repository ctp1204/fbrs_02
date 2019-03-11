class BooksController < ApplicationController
  before_action :find_book, except: %i(index new create)

  def index
    if params[:category].blank?
      @books = Book.order_book
    else
      @category_id = Category.find_by id: params[:category]
      @books = Book.active(@category_id).order_book
    end
  end

  def show; end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
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
    params.require(:book).permit :title,
      :publish_date, :content, :description, :author, :publisher,
      :rate_points, :number_pages, :category_id, :book_img
  end

  def find_book
    @book = Book.find_by_id params[:id]
    return if @book
    flash[:danger] = t "messenger"
    redirect_to books_path
  end

end
