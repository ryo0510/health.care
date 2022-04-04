class Course < ApplicationRecord
  belongs_to :category
  has_many :entries, dependent: :destroy

  enum way: { sign: 0, number: 1 }

  validates :name, presence: true, uniqueness: true, length: { maximum: 15 }
  validates :working_item, presence: true
  validates :target_date, numericality: { only_integer: true, greater_than_or_equal_to: 1 } # 数値かつ、1以上
  validates :way, presence: true

  def self.create_all_ranks # ランキング(登録人数)
    Course.find(Entry.group(:course_id).order('count(course_id) desc').limit(3).pluck(:course_id))
  end
end
