class History < ApplicationRecord
  belongs_to :customer
  belongs_to :course_result

  validates :customer_id, presence: true
  validates :course_result_id, presence: true
  validates :result, presence: true
  validates :start_time, presence: true, uniqueness: { scope: :course_result } #1つのcourse_result_idでのみ適用

end
