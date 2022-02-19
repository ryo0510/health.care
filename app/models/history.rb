class History < ApplicationRecord
  belongs_to :customer
  belongs_to :course_result

  validates :customer_id, presence: true
  validates :course_result_id, presence: true
  validates :result, presence: true
  validates :start_time, presence: true, uniqueness: { scope: :course_result } #1つのcourse_result_idでのみ適用

  scope :created_today, -> { find_by(start_time: Time.zone.now.midnight..Time.zone.now.end_of_day) } # 今日
  scope :created_yesterday, -> { find_by(start_time: 1.day.ago.midnight..1.day.ago.end_of_day) } # 前日
  scope :created_2day_ago, -> { find_by(start_time: 2.day.ago.midnight..2.day.ago.end_of_day) } # 2日前
  scope :created_3day_ago, -> { find_by(start_time: 3.day.ago.midnight..3.day.ago.end_of_day) } # 3日前
  scope :created_4day_ago, -> { find_by(start_time: 4.day.ago.midnight..4.day.ago.end_of_day) } # 4日前
  scope :created_5day_ago, -> { find_by(start_time: 5.day.ago.midnight..5.day.ago.end_of_day) } # 5日前
  scope :created_6day_ago, -> { find_by(start_time: 6.day.ago.midnight..6.day.ago.end_of_day) } # 6日前

end
