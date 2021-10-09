class BooksController < ApplicationController

  before_action :ensure_current_user, {only: [:edit]}

  def ensure_current_user
    if current_user.id != params[:id].to_i
      flash[:alert] = "You have no authority to access the page."
      redirect_to books_path
    end
  end

  def index
    @books = Book.all
    @book = Book.new

    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])

    @user = current_user
  end

  def edit
    @book = Book.find(params[:id])
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
    params.require(:book).permit(:title, :opinion)
  end
end
