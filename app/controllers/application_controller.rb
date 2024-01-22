class ApplicationController < ActionController::Base
  # /adminを含むパスじゃなかったらユーザー側ログイン認証。topとaboutは除外
  before_action :authenticate_user!, except: [:top, :about], unless: :admin_url
  # /adminを含むパスなら、管理者側ログイン認証。
  before_action :authenticate_admin!, if: :admin_url
  # deviseを利用する機能(ユーザー登録やログイン認証等)が行われる前にメソッド実行
  before_action :configure_permitted_parameters, if: :devise_controller?


  # protectedは呼び出された他のコントローラからも参照することができる
  protected
  # パスに「/admin」が含まれているか確認。
  # request.fullpathで飛んだ先のpathを全て取得。include?(/admin)で/adminと同じ要素が含まれていれば、trueを返す。
  def admin_url
    request.fullpath.include?("/admin")
  end

  # ユーザー登録のときにユーザー名のデータ操作を許可する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :admin, :nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :admin, :nickname])
  end

end
