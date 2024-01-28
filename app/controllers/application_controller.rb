class ApplicationController < ActionController::Base
  # ユーザーログイン認証。topとaboutは除外
  before_action :authenticate_user!, except: [:top, :about]
  before_action :authenticate_admin!, if: :admin_url, unless: :admin_user?
  # deviseを利用する機能(ユーザー登録やログイン認証等)が行われる前にメソッド実行
  before_action :configure_permitted_parameters, if: :devise_controller?


  # protectedは呼び出された他のコントローラからも参照することができる
  protected

  def admin_url
    request.fullpath.include?("/admin")
  end

  def admin_user?
    current_user && current_user.admin? # current_userが存在し、かつadmin権限を持っている場合にtrueを返すように実装する
  end

  # ユーザー登録のときにユーザー名のデータ操作を許可する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :admin, :nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :admin, :nickname])
  end

end
