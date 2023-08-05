class Item < ApplicationRecord
  
  has_many :cart_items
  has_many :orders
  has_many :order_details
  
  has_one_attached :image
  
  def get_image
    unless image.attached?
      image
    else
      'no_image.jpg'
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def tax_included_price
    price * 1.1
  end
  
end
