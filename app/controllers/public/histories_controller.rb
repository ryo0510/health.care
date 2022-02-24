class Public::HistoriesController < ApplicationController
  before_action :authenticate_customer!
  
  def create
    course_result = CourseResult.find(params[:course_result_id])
    history = current_customer.histories.new(history_params)
    history.course_result_id = course_result.id
    if history.save
      redirect_to course_result_path(course_result), notice: '登録が完了しました。'
    else
      # renderだと、エラーメッセージ表示後にカレンダーの前月、次月を押すとエラー(URLと画面の不整合)になる。他にやり方がある？
      redirect_to course_result_path(course_result), alert: '既に登録されている日付か、数値が未入力です'
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
