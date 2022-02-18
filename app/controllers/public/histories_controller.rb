class Public::HistoriesController < ApplicationController
  def create
    course_result = CourseResult.find(params[:course_result_id])
    history = current_customer.histories.new(history_params)
    history.course_result_id = course_result.id

    @course_result = CourseResult.find(params[:course_result_id])
    @history = History.new
    @histories = @course_result.histories.order("start_time DESC").page(params[:page]).per(5)

    if history.save
      redirect_to course_result_path(course_result)
    else
      flash.now[:alert] = "既に登録されている日付です"
      render 'public/course_results/show'
    end
  end

  def destroy
    History.find_by(id: params[:id]).destroy
    redirect_to course_result_path(params[:course_result_id])
  end

  private

  def history_params
    params.require(:history).permit(:result, :memo, :start_time)
  end
end
