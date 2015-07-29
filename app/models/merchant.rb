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
    all.sort_by{ |merchant| merchant.total_revenue }.last(quantity).reverse
  end
  
  def total_revenue
    invoices.successful.joins(:invoice_items).sum("quantity * unit_price")
  end
  
  def self.most_items(quantity)
    all.sort_by{ |merchant| merchant.total_items }.last(quantity).reverse
  end
  
  def total_items
    invoices.successful.joins(:invoice_items).sum(:quantity)
  end
  
  def self.revenue_by_date(date)
    all.inject(0) { |sum, merchant| sum + merchant.revenue_by_date(date) }
  end
  
  def revenue_by_date(date)
    invoices.successful.where(created_at: date).joins(:invoice_items).sum("quantity * unit_price")
  end
  
  def favorite_customer
    Customer.find(invoices.successful.top_customer_id)
  end
  
  def customers_with_pending_invoices
    invoices.unpaid.map{ |invoice| invoice.customer }
  end
end
