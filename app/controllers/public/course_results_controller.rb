class Public::CourseResultsController < ApplicationController
  def edit
    @course_result = CourseResult.find(params[:id])

    # 現在の曜日と年月日
    date_now = Date.current

    @weeks = ["日", "月", "火", "水", "木", "金", "土"]
    
    firstDay = date_now.beginning_of_month
    firstDayIndex = firstDay.wday
    @calender = Array.new(70){|i| date_now - (i - firstDayIndex)}
  end

  def update
    @course_result = CourseResult.find(params[:id])
    if @course_result.update(course_result_params)
      flash[:notice] = "更新に成功しました"
    end
    redirect_to request.referer
  end

  private

  def course_result_params
    params.require(:course_result).permit(:history, :memo)
  end
end
