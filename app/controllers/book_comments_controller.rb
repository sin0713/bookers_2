class BookCommentsController < ApplicationController

  def create

    @book = Book.find(params[:book_id])

    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    @book_comments = @book.book_comments

     if @book_comment.save
       flash[:notice] = "Comment has created successfully"

     else
       @new_book = Book.new
       @user = User.find(@book.user_id)
       render 'books/show'
     end
  end

  def destroy
    @book_comments = BookComment.where(book_id: params[:book_id])
    BookComment.find_by(id: params[:id]).destroy
  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
