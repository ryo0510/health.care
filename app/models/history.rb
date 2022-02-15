class History < ApplicationRecord
  belongs_to :customer
  belongs_to :course_result
end
