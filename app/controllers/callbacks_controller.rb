class CallbacksController < Devise::OmniauthCallbacksController
  def create
    @user = User.from_omniauth request.env["omniauth.auth"]
    provider = request.env["omniauth.auth"].provider
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message :success, :success, kind: provider
    else
      session["devise.auth_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_path
    end
  end
end
