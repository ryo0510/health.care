class Course < ApplicationRecord
  belongs_to :category
  has_many :entries, dependent: :destroy

  enum way: { sign: 0, number: 1 }

  def self.create_all_ranks #ランキング(登録人数)
    Course.find(Entry.group(:course_id).order('count(course_id) desc').limit(3).pluck(:course_id))
  end
end
