class Admin::CoursesController < ApplicationController
  before_action :ensure_course, only: [:show, :edit, :update]

  def new
    @course = Course.new
  end

  def index
    @items = Item.all
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash.now[:notice] = "コースを追加しました。"
      redirect_to admin_course_path(@course)
    else
      flash.now[:alert] = "コースを追加できませんでした。"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @course.update(course_params)
      flash.now[:notice] = "編集内容を更新しました。"
      redirect_to admin_course_path(@course)
    else
      flash.now[:alert] = "入力内容を確認してください。"
      render :edit
    end
  end

  private

  def course_params
    params.require(:course).permit(:category_id, :name, :working_item, :target_date, :way)
  end

  def ensure_course
    @course = Course.find(params[:id])
  end
end
