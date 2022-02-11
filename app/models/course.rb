class Course < ApplicationRecord
  belongs_to :category
  has_many :entries, dependent: :destroy

  enum way: { sign: 0, number: 1 }
end
