class ApplicationController < ActionController::Base
  # アクションを実行する前にログインしているユーザーであることを確認
  # exceptによって、topとaboutはこの処理から除外される
  before_action :authenticate_user!, except: [:top, :about], if: :public_url
  # ユーザーが触れないように認証
  before_action :authenticate_admin!, if: :admin_url
  # deviseを利用する機能(ユーザー登録やログイン認証等)が行われる前にメソッド実行
  before_action :configure_permitted_parameters, if: :devise_controller?


  # protectedは呼び出された他のコントローラからも参照することができる
  protected

  # パスに「/userもしくは/mypage」が含まれているか確認。
  # request.fullpathで飛んだ先のpathを全て取得。include?(val)でvalと同じ要素が含まれていれば、trueを返す。
  def public_url
    request.fullpath.include?("/public") || request.fullpath.include?("/mypage")
  end

  # パスに「/admin」が含まれているか確認。
  # request.fullpathで飛んだ先のpathを全て取得。include?(val)でvalと同じ要素が含まれていれば、trueを返す。
  def admin_url
    request.fullpath.include?("/admin")
  end

  # ユーザー登録のときにユーザー名のデータ操作を許可する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

end
