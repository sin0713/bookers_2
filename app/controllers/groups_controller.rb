class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def new
    @group = Group.new(owner_id: current_user.id)
  end

  def create
    @group = Group.new(group_params)
    @group.save
    @group_users = current_user.group_users.create(group_id: @group.id)
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image_id, :owner_id)
  end
end
