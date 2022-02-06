class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :image
  has_many :post_messages, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def full_name
   last_name + " " + first_name
  end

  def full_name_kana
    last_name_kana + " " + first_name_kana
  end

end
