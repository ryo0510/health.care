class Course < ApplicationRecord
  belongs_to :category
  has_many :entry_courses, dependent: :destroy
  has_many :course_results

  enum way: { sign: 0, number: 1 }
end
