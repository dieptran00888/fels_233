class Admin::UsersController < ApplicationController 
  load_and_authorize_resource 

  def index
    @users = User.paginate page: params[:page]
  end

   def destroy
    unless @user.destroy
      flash.now[:danger] = t "user_delete_error_message"
    end
    respond_to do |format|
      format.js
    end
  end
end
