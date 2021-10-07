class BooksController < ApplicationController
  def index
     
    @user = User.find(current_user.id)
  end

  def show
  end

  def edit
  end
end
