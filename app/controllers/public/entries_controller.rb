class Public::EntriesController < ApplicationController
  before_action :authenticate_customer!

  def new
    @entry = Entry.new

    #ランキング(モデルにメソッド記載)
    @all_ranks = Course.create_all_ranks
  end

  def create
    @entry = Entry.new
    @all_ranks = Course.create_all_ranks

    #rejectで要素に空白があった場合、削除する
    entries = (params[:entry][:course_id]).compact.reject(&:empty?)
    if Entry.where(course_id: entries).where(customer_id: current_customer.id).count >= 1
      redirect_to new_entry_path, alert: '登録済みのコースが含まれています'
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

  def destroy
    entry = Entry.find(params[:id])
    entry.destroy
    redirect_to request.referer, notice: '削除しました'
  end

  private

  def create_params
    params.require(:entry).permit(course_id: [])
  end

end
