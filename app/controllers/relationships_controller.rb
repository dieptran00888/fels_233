class RelationshipsController < ApplicationController
  load_resource

  def create
    @user = User.find_by id: params[:followed_id]
    unless current_user.following? @user
      current_user.follow @user
      @relationship = current_user.active_relationships.
        find_by followed_id: @user.id
      create_activity Activity.types[:follow], current_user.id, @user.id
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
      end
    end
  end

  def destroy
    @relationship = Relationship.find_by id: params[:id]
    if @relationship
      @user = @relationship.followed
      current_user.unfollow @user
      create_activity Activity.types[:unfollow], current_user.id, @user.id
      @relationship = current_user.active_relationships.build
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
      end
    end
  end

  private
  def create_activity type, user_id, target_id
    Activity.create action_type: type, user_id: user_id, target_id: target_id
  end
end
