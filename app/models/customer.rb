class Customer < ActiveRecord::Base
  validates :first_name,
    presence: true
  validates :last_name,
    presence: true
  validates :created_at,
    presence: true
  validates :updated_at,
    presence: true
  
  has_many :invoices
  has_many :merchants, through: :invoices
  
  def favorite_merchant
    Merchant.find(invoices.successful.top_merchant_id)
  end
end
