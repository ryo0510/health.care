class CourseResult < ApplicationRecord
  belongs_to :entry
  has_many :histories, dependent: :destroy
  
  validates :entry_id, presence: true
  
end