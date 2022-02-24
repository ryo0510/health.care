class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :post_message

  validates :customer_id, presence: true
  validates :post_message_id, presence: true, uniqueness: { scope: :customer_id }
end
