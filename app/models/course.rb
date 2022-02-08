class Course < ApplicationRecord
  belongs_to :category

  enum way: { sign: 0, number: 1 }
end
