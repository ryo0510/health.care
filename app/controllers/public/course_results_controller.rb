class Public::CourseResultsController < ApplicationController
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
