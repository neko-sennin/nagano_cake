class Customer < ApplicationRecord
  
  has_many :cart_items, dependent: :destroy
  
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
