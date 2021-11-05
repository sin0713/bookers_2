class BooksController < ApplicationController
  include Typeable

  before_action :set_new_book, only: [:index, :show]

  def index
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def show
    @show_book = Book.find(params[:id])
    @user = User.find(@show_book.user_id)
    @book_comment = BookComment.new
    @book_comments = @show_book.book_comments
  end

  def edit
    @book = Book.find(params[:id])
    if current_user.id != @book.user_id
      flash[:alert] = "You have no authority to access the page."
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
     render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      flash[:alert] = "You have deleted book successfully."
      redirect_to books_path
    end
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
