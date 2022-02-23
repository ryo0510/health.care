class Admin < ApplicationRecord
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |admin|
      admin.password = SecureRandom.urlsafe_base64
    end
  end
end
