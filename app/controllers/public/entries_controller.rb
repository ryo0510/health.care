class Public::EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def create
    #rejectで要素に空白があった場合、削除する
    converted_create_params = create_params[:course_id].reject { |v| v.empty? }.map(&:to_i)
    #データの一貫性を保つためトランザクション使用(どちらかの処理に異常があった場合、rollbackする)
    ActiveRecord::Base.transaction do
      converted_create_params.each do |course_id|
        entry = current_customer.entries.create!(course_id: course_id)
        course = entry.course_results.create!(entry_id: entry.id)
      end
    end
    redirect_to customers_mypage_path
  end

  def index
    @entries = current_customer.entries.all

    # 現在の曜日と年月日
    date_now = Date.current

    @weeks = ["日", "月", "火", "水", "木", "金", "土"]

    firstDay = date_now.beginning_of_month
    firstDayIndex = firstDay.wday
    @calender = Array.new(45){|i| firstDay - (i + firstDayIndex)}
  end

  private

  def create_params
    params.require(:entry).permit(course_id: [])
  end

end
