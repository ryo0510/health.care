class Public::CoursesController < ApplicationController
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

  def show
    @course = Course.find(params[:id])
  end

  def search
    if params[:keyword].present?
      @courses = Course.where('caption LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @courses = Course.all
    end
  end

end
