class Public::EntryCoursesController < ApplicationController
  def new
    @course = Course.new
  end

  private

  def entry_course_params
    params.require(:entry_course).permit(:customer_id, :course_id)
  end

end
