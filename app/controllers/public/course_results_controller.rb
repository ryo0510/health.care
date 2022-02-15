class Public::CourseResultsController < ApplicationController
  def show
    @course_result = CourseResult.find(params[:id])
    @history = History.new
  end

end
