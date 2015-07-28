class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  
  def self.most_revenue(quantity)
    # pull all successful invoices
    # pull all the invoice_items for those invoices
    # iterate through them and multiply the quantity by unit price
  end
end
