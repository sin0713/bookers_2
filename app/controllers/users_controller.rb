class UsersController < ApplicationController

  before_action :set_user, except: [:index]

  def show
    @books = Book.where(user_id: @user.id) #もしくは @books = @user.books なぜならテーブル同士アソシエーションで関連付けが行われているか
    @book = Book.new

    begin
      @day_before_ratio = (@books.created_today.count / @books.created_days_ago(1).count) * 100
    rescue
      @day_before_ratio = "--%"
    end

    begin
      @week_before_ratio = (@books.created_this_week.count / @books.created_last_week.count) * 100
    rescue
      @week_before_ratio = "--%"
    end
  end

  def edit
    if current_user.id != @user.id
      flash[:alert] = "You have no authority to access the page."
      redirect_to user_path(current_user)
    end
  end

  def update
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
    @users = @user.followings
  end

  def followers
    @users = @user.followers
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
