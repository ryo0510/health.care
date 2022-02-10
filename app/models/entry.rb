class Entry < ApplicationRecord
  belongs_to :customer
  belongs_to :course
  
  def create_course_results(customer)
    p customer
  end
end


