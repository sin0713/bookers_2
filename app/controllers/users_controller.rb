class UsersController < ApplicationController
 

  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user.id) #もしくは @books = @user.books.all

    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if current_user.id != @user.id
      flash[:alert] = "You have no authority to access the page."
      redirect_to user_path(current_user)
    end 
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end


  def index
    @users = User.all

    @book = Book.new
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
