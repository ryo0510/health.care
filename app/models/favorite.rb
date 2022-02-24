class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :post_message

  validates :post_message_id, uniqueness: { scope: :customer_id }
end
