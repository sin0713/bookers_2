class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @following = current_user.relationships.build(followed_id: params[:id])
    followind.save
    redirect_to request.referrer || root_path
  end
  
  def destroy
    @following = current_user.relationships.find_by(followed_id: params[:id])
    @following.destroy
    redirect_top request.referrer || root_path
  end
  
end
