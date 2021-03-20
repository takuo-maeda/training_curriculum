class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    get_week
    @plan = Plan.new
  end

  # 予定の保存
  def create
    # binding.pry
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
    # binding.pry
  end

  def get_week
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)
    # Rubyの範囲指定子..と...
    # A..B（B含む）
    # A...B(B含まない)

    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
        #配列追加メソッドpush today_plansにプランを追加
      end
      days = { month: (@todays_date + x).month, date: (@todays_date + x).day, plans: today_plans}
        #monthメソッド　時間や日付を取得しその月だけ取り出す
        #day 時間や日付を取得しその月だけ取り出す
      @week_days.push(days)
    end
  end
end
