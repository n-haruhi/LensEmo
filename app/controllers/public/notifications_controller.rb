class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def update
    # ログインしているユーザに紐づく通知レコードから指定のidのレコードを取得
    # ここでの更新はreadカラムをtrueに。未読から既読への更新=>既読状態のこと
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    redirect_to notification.notifiable_path
  end

end
