class CourseResult < ApplicationRecord
  belongs_to :entry
  has_many :histories, dependent: :destroy
end