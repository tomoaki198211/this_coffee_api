class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController

  private
  #登録時にnameを受け付ける
  def sign_up_params
    params.require(:registration).permit(:email, :password, :password_confirmation,:name)
  end
  #アカウント更新時にnameを受け付ける
  def account_update_params
    params.require(:registration).permit(:email, :password, :password_confirmation,:name)
  end
end
