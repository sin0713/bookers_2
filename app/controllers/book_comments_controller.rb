class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id

     if @book_comment.save
       flash[:notice] = "Comment has created successfully"
       redirect_to book_path(@book)
     else
       @new_book = Book.new
       @user = User.find(@book.user_id)
       render 'books/show'
     end
  end

  def destroy
    BookComment.find_by(id: params[:id]).destroy
    redirect_to book_path(params[:book_id])
  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
