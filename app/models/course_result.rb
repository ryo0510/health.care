class CourseResult < ApplicationRecord
  belongs_to :customer
  belongs_to :course
end
