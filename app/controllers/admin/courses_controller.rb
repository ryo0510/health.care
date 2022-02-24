class Admin::CoursesController < ApplicationController
  before_action :ensure_course, only: [:show, :edit, :update]
  before_action :authenticate_admin!

  def new
    @course = Course.new
  end

  def index
   # urlにcategory_id(params)がある場合
    if params[:category_id]
      # Categoryのデータベースのテーブルから一致するidを取得
      @category = Category.find(params[:category_id])
      # category_idと紐づくコースを取得
      @courses = @category.courses.order(created_at: :desc).all
    else
      # コースすべてを取得
      @courses = Course.order(created_at: :desc).all
    end
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to admin_course_path(@course), notice: "コースを登録しました"
    else
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to admin_course_path(@course), notice: "登録情報を更新しました"
    else
      render "edit"
    end
  end

  private

  def course_params
    params.require(:course).permit(:category_id, :name, :working_item, :working_item_second, :working_item_third, :target_date, :way)
  end

  def ensure_course
    @course = Course.find(params[:id])
  end
end
