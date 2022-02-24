class PostMessage < ApplicationRecord
  belongs_to :customer
  has_many :favorites, dependent: :destroy

  attachment :image

  validates :customer_id, presence: true
  validates :nickname, presence: true, length: { maximum: 10 }
  validates :message, presence: true, length: { maximum: 140 }

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end
end
