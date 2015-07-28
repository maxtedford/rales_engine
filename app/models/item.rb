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
end
