class Public::CoursesController < ApplicationController
  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @courses = @category.courses.order(created_at: :desc).all
    else
      @courses = Course.order(created_at: :desc).all
    end
  end

  def show
    @course = Course.find(params[:id])
  end

  def search
    if params[:keyword].present?
      @courses = Course.where('name LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @courses = Course.all
    end
  end
end
