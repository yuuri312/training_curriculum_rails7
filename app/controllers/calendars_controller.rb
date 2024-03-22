class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    getWeek
    @plan = Plan.new
  end

  # 予定の保存
  def create
    @Plan = Plan.new(plan_params)
    
  # 予定の保存
  def create
    @plan = Plan.new(plan_params)
    
    if @plan.save
      redirect_to root_path, notice: '予定を保存しました。'
    else
      redirect_to root_path, alert: '予定の保存に失敗しました。'
    end
  end  
  

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
  end

  def getWeek
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days= []
   
    (0..6).each do |x|
      today_plans = Plan.where(date: @todays_date+x)
      days={month: (@todays_date + x).month,date: (@todays_date+x).day,wday: wdays[(@todays_date+x).wday],plans: today_plans}
      @week_days.push(days)
    end
  end
