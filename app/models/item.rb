class Item < ActiveRecord::Base
  validates :name,
    presence: true
  validates :description,
    presence: true
  validates :unit_price,
    presence: true
  validates :merchant_id,
    presence: true
  validates :created_at,
    presence: true
  validates :updated_at,
    presence: true
  
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  
  def self.most_revenue(quantity)
    all.sort_by{ |item| item.total_revenue }.last(quantity).reverse
  end
  
  def total_revenue
    invoices.successful.joins(:invoice_items).sum('"invoice_items"."quantity" * "invoice_items"."unit_price"')
  end
  
  def self.most_items(quantity)
    all.sort_by{ |item| item.total_items }.last(quantity)
  end
  
  def total_items
    invoices.successful.joins(:invoice_items).sum('"invoice_items"."quantity"')
  end
  
  def best_day
    invoices.successful.group('invoices.created_at').sum('quantity * unit_price').sort_by(&:last).reverse.first[0]
  end
end
