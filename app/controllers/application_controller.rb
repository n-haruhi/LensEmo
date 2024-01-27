class ApplicationController < ActionController::Base
  # ユーザーログイン認証。topとaboutは除外
  before_action :authenticate_user!, except: [:top, :about]
  # deviseを利用する機能(ユーザー登録やログイン認証等)が行われる前にメソッド実行
  before_action :configure_permitted_parameters, if: :devise_controller?


  # protectedは呼び出された他のコントローラからも参照することができる
  protected

  # ユーザー登録のときにユーザー名のデータ操作を許可する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :admin, :nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :admin, :nickname])
  end

end
