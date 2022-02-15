class Public::HistoriesController < ApplicationController
  def create
    course_result = CourseResult.find(params[:course_result_id])
    history = current_customer.histories.new(history_params)
    history.course_result_id = course_result.id
    history.save
    redirect_to course_result_path(course_result)
  end

  def destroy
    History.find_by(id: params[:id]).destroy
    redirect_to course_result_path(course_result)
  end

  private

  def history_params
    params.require(:history).permit(:result, :memo, :start_time)
  end
end
