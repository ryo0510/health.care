class History < ApplicationRecord
  belongs_to :customer
  belongs_to :course_result

  validates :customer_id, presence: true
  validates :course_result_id, presence: true
  validates :result, presence: true
  validates :memo, length: { maximum: 140 } 
  validates :start_time, presence: true, uniqueness: { scope: :course_result } #1つのcourse_result.idでのみ適用

  def self.created_today
    res = find_by(start_time: Time.zone.now.midnight..Time.zone.now.end_of_day) #今日
    res.nil? ? 0 : res.result #三項演算子使用(resがnilの場合左辺を返し、それ以外は右辺を返す)
  end

  def self.created_yesterday
    res = find_by(start_time: 1.day.ago.midnight..1.day.ago.end_of_day) #昨日
    res.nil? ? 0 : res.result
  end

  def self.created_2day_ago #2日前
    res = find_by(start_time: 2.day.ago.midnight..2.day.ago.end_of_day)  #2日前
    res.nil? ? 0 : res.result
  end

  def self.created_3day_ago
    res = find_by(start_time: 3.day.ago.midnight..3.day.ago.end_of_day)  #3日前
    res.nil? ? 0 : res.result
  end

  def self.created_4day_ago
    res = find_by(start_time: 4.day.ago.midnight..4.day.ago.end_of_day)  #4日前
    res.nil? ? 0 : res.result
  end

  def self.created_5day_ago
    res = find_by(start_time: 5.day.ago.midnight..5.day.ago.end_of_day)  #5日前
    res.nil? ? 0 : res.result
  end

  def self.created_6day_ago
    res = find_by(start_time: 6.day.ago.midnight..6.day.ago.end_of_day)  #6日前
    res.nil? ? 0 : res.result
  end
  
end