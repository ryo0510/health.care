class Public::CourseResultsController < ApplicationController
  def show
    @result = CourseResult.new
    @course_result = CourseResult.find(params[:id])

  end

  def create
    @course_result = CourseResult.new(course_result_params)
    @course_result.save
    redirect_to request.referer

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
    params.require(:course_result).permit(:history, :memo, :start_time)
  end
end
