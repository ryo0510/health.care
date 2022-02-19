class Public::EntriesController < ApplicationController
  before_action :authenticate_customer!

  def new
    @entry = Entry.new

    #ランキング(登録順)
    @all_ranks = Course.create_all_ranks
  end

  def create
    @entry = Entry.new
    @all_ranks = Course.create_all_ranks

    #rejectで要素に空白があった場合、削除する
    entries = (params[:entry][:course_id]).compact.reject(&:empty?)

    if Entry.where(course_id: entries).where(customer_id: current_customer.id).count >= 1
      flash.now[:alert] = "登録済みのコースが含まれていた為、登録できませんでした。"
      render "new"
      return
    end

    #rejectで要素に空白があった場合、削除する
    converted_create_params = create_params[:course_id].reject { |v| v.empty? }.map(&:to_i)
    #データの一貫性を保つためトランザクション使用(どちらかの処理に異常があった場合、処理を中断しデータを保存しない)
    ActiveRecord::Base.transaction do
      converted_create_params.each do |course_id|
        entry = current_customer.entries.create!(course_id: course_id)
        course = entry.course_results.create!(entry_id: entry.id)
      end
    end
    redirect_to entries_path
  end

  def index
    @entries = current_customer.entries.all
  end

  private

  def create_params
    params.require(:entry).permit(course_id: [])
  end

end
