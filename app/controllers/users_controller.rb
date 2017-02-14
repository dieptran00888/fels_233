class UsersController < ApplicationController
  load_resource

  def show
    @relationship = if current_user.following? @user
      current_user.active_relationships.find_by followed_id: @user.id
    else
      current_user.active_relationships.build
    end
  end

  def edit
  end

  def update
    if @user.update_with_password user_params
      flash[:success] = t "user.success"
    else
      flash[:danger] = t "user.fail"
    end
    redirect_to @user
  end

  private
  def user_params
    params.require(:user).permit :email, :name, :password,
     :password_confirmation, :current_password
  end
end
