class Public::EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def create
    entry = current_customer.entries.create(entry_params)
    course_result =current_customer.course_results.create(entry_params)
    flash.now[:notice] = "コースを追加しました。"
    redirect_to customers_mypage_path
  end

  private

  def entry_params
    params.require(:entry).permit(:course_id)
  end

end
