class GroupUsersController < ApplicationController
  def create
    group_user = current_user.group_users.build(group_id: params[:group_id])
    group_user.save
    redirect_to request.referrer
  end

  def destroy
    group_user = current_user.group_user.find_by(group_id: params[:group_id])
    group.destroy
    redirect_to request.referrer
  end
end
