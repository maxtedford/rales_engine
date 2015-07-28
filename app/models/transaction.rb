class Transaction < ActiveRecord::Base
  validates :invoice_id,
    presence: true
  validates :credit_card_number,
    presence: true
  validates :result,
    presence: true
  validates :created_at,
    presence: true
  validates :updated_at,
    presence: true
  
  belongs_to :invoice
end
