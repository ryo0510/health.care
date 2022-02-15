class Public::CourseResultsController < ApplicationController
  def show
    @course_result = CourseResult.find(params[:id])
    @history = History.new
    @histories = @course_result.histories.order("start_time DESC")
  end
end
