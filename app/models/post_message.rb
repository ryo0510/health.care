class PostMessage < ApplicationRecord
  belongs_to :customer
  has_many :favorites, dependent: :destroy

  attachment :image

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end
end
