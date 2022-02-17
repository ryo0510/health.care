class Public::CourseResultsController < ApplicationController
  def show
    @course_result = CourseResult.find(params[:id])
    @history = History.new
    @histories = @course_result.histories.order("start_time DESC").page(params[:page]).per(5)
    Date.beginning_of_week = :sunday #日曜日から始まり(カレンダー)
  end
end
