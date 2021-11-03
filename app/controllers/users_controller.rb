class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user.id) #もしくは @books = @user.books なぜならテーブル同士アソシエーションで関連付けが行われているか
    @book = Book.new
    @today_books = @books.created_today
    @yesterday_books = @books.created_yesterday
    @this_week_books = @books.created_this_week
    @last_week_books = @books.created_last_week

    begin
      @day_before_ratio = (@today_books.count / @yesterday_books.count) * 100
    rescue
      @day_before_ratio = "--%"
    end

    begin
      @week_before_ratio = (@this_week_books.count / @last_week_books.count) * 100
    rescue
      @week_before_ratio = "--%"
    end
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

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
