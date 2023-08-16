class Order < ApplicationRecord
  
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details
  belongs_to :customer
  
  enum payment_method: { credit_card: 0, transfer: 1 }
  
  def order_profile(postal_code, address, name)
    self.postal_code = postal_code
    self.address = address
    self.name = name
  end
  
   cart_item.tax_included_price
  
end
