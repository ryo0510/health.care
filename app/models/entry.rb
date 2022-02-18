class Entry < ApplicationRecord
  belongs_to :customer
  belongs_to :course
  has_many :course_results, dependent: :destroy

  validates :course_id, presence: true, uniqueness: { scope: :customer }
  validates :customer_id, presence: true
end


