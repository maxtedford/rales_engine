class Merchant < ActiveRecord::Base
  validates :name,
    presence: true
  validates :created_at,
    presence: true
  validates :updated_at,
    presence: true
  
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  
  def self.most_revenue(quantity)
    # pull all successful invoices
    # pull all the invoice_items for those invoices
    # iterate through them and multiply the quantity by unit price
  end
end
