class Entry < ApplicationRecord
  belongs_to :customer
  belongs_to :course
  has_many :course_results, dependent: :destroy
  
  validates :course_id, presence: true, uniqueness: true
  validates :customer_id, presence: true
end


