class Public::EventsController < ApplicationController
  # @eventsの中身をviews/events/calendar.json.jbuilderにてJSONに変換
  def index
    @events = Event.all
    respond_to do |format|
      format.html # カレンダーの表示にはHTML形式を使用
      format.json { render json: @events } # JSON形式のレスポンスを返す
    end
  end

end
