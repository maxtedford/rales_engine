class Invoice < ActiveRecord::Base
  validates :customer_id,
    presence: true
  validates :merchant_id,
    presence: true
  validates :status,
    presence: true
  validates :created_at,
    presence: true
  validates :updated_at,
    presence: true
  
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  
  def self.successful
    joins(:transactions).where(transactions: { :result => "success" } )
  end
  
  def self.unpaid
    all - successful
  end
  
  def self.top_customer_id
    joins(:customer).group(:customer_id).count.sort_by{|_, count| count}.reverse.first[0]
  end
end
