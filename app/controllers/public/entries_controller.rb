class Public::EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def create
    @entry = current_customer.entries.new(entry_params)
      @entry.save
      @entry.create_course_results(current_customer)
      flash.now[:notice] = "コースを追加しました。"
      redirect_to customers_mypage_path
  end

  private

  def entry_params
    params.require(:entry).permit(:custoemr_id, :course_id)
  end

end
