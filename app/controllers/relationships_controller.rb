class RelationshipsController < ApplicationController
  load_resource

  def create
    @user = User.find_by id: params[:followed_id]
    unless current_user.following? @user
      current_user.follow @user
      @relationship = current_user.active_relationships.
        find_by followed_id: @user.id
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
      @relationship = current_user.active_relationships.build
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
      end
    end
  end
end
