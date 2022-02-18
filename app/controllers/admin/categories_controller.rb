class Admin::CategoriesController < ApplicationController
  before_action :ensure_category, only: [:edit, :update]
  before_action :authenticate_admin!

  def index
    @category = Category.new
    @categories = Category.all
  end

  def create
    @categories = Category.all
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      flash.now[:alert] = "入力内容をご確認ください"
      render :index
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def ensure_category
    @category = Category.find(params[:id])
  end

end
