class Public::CourseResultsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer

  def show
    @course_result = CourseResult.find(params[:id])
    @history = History.new
    @histories = @course_result.histories.order("start_time DESC").page(params[:page]).per(5)
    Date.beginning_of_week = :sunday # 日曜日から始まり(カレンダー)
  end

  private

  def ensure_correct_customer
    @course_result = CourseResult.find(params[:id])
    unless @course_result.entry.customer == current_customer
      redirect_to root_path
    end
  end
end
