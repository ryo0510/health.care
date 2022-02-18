class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :post_message
  
  validates_uniqueness_of :post_message_id, scope: :customer_id
  
end
