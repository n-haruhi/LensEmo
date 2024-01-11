class ApplicationController < ActionController::Base
  # コントローラ内のすべてのアクションが実行される前に実行される
  # アクションを実行する前にログインしているユーザーであることを確認
  # exceptによって、topとaboutはこの処理から除外される
  before_action :authenticate_user!, except: [:top, :about]
  # deviseを利用する機能(ユーザー登録やログイン認証等)が行われる前にメソッド実行
  before_action :configure_permitted_parameters, if: :devise_controller?


  # protectedは呼び出された他のコントローラからも参照することができる
  protected

  # ユーザー登録のときにユーザー名のデータ操作を許可する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

end
