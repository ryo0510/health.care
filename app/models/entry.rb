class Entry < ApplicationRecord
  belongs_to :customer
  belongs_to :course
  has_many :course_results, dependent: :destroy
end


