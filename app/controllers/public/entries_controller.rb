class Public::EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def create
    @entry = current_customer.entries.create(entry_params)
    @course_result = course_results.create(result_params)
    redirect_to customers_mypage_path
  end

  def show
     @entry = Entry.find(params[:id])
  end

  private

  def entry_params
    params.require(:entry).permit(:course_id)
  end

  def result_params
    params.require(:course_result).permit(:entry_id)
  end

end
