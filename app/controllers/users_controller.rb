class UsersController < ApplicationController
  include Typeable
  before_action :set_user, except: [:index]
  before_action :set_new_book, only: [:show, :index]

  def show
    @books = Book.where(user_id: @user.id) #もしくは @books = @user.books なぜならテーブル同士アソシエーションで関連付けが行われているか
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
