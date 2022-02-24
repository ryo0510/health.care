class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :validatable

  has_many :post_messages, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :histories, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\u{30fc}]+\z/, message: "全角カタカナのみで入力して下さい" }
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\u{30fc}]+\z/, message: "全角カタカナのみで入力して下さい" }
  validates :address, presence: true
  validates :tel, numericality: { only_integer: true } # 数値のみ
  validates :email, presence: true, uniqueness: true

  def full_name
   last_name + " " + first_name
  end

  def full_name_kana
    last_name_kana + " " + first_name_kana
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
    end
  end

end
