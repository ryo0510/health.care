class History < ApplicationRecord
  belongs_to :customer
  belongs_to :course_result
  
  validates :customer_id, presence: true
  validates :course_result_id, presence: true
  validates :result, presence: true, length: { maximum: 5 }
  validates :start_time, presence: true, uniqueness: true
  
end
