require 'rails_helper'

describe 'Transaction', :type => :model do

  let(:merchant) { Merchant.create(name: "Justin Bieber",
                                   created_at: "2012-03-27 14:53:59 UTC",
                                   updated_at: "2012-03-27 14:53:59 UTC") }

  let(:customer) { Customer.create(first_name: "Johnny",
                                   last_name: "Walker",
                                   created_at: "2012-03-27 14:53:59 UTC",
                                   updated_at: "2012-03-27 14:53:59 UTC") }

  let(:item) { Item.create(name: "Item",
                           description: "Item description",
                           unit_price: 10,
                           merchant_id: merchant.id,
                           created_at: "2012-03-27 14:53:59 UTC",
                           updated_at: "2012-03-27 14:53:59 UTC") }

  let(:invoice) { Invoice.create(customer_id: customer.id,
                                 merchant_id: merchant.id,
                                 status: "shipped",
                                 created_at: "2012-03-27 14:53:59 UTC",
                                 updated_at: "2012-03-27 14:53:59 UTC") }

  let(:invoice_item) { InvoiceItem.create(item_id: item.id,
                                          invoice_id: invoice.id,
                                          quantity: 5,
                                          unit_price: 10,
                                          created_at: "2012-03-27 14:53:59 UTC",
                                          updated_at: "2012-03-27 14:53:59 UTC") }

  let(:transaction) { Transaction.create(invoice_id: invoice.id,
                                         credit_card_number: "2424242424242424",
                                         credit_card_expiration_date: nil,
                                         result: "success'",
                                         created_at: "2012-03-27 14:53:59 UTC",
                                         updated_at: "2012-03-27 14:53:59 UTC") }
  
  it 'is valid' do
    expect(transaction).to be_valid
  end
  
  it 'is invalid without an invoice id' do
    transaction = Transaction.create(credit_card_number: "2424242424242424",
                                     credit_card_expiration_date: nil,
                                     result: "success'",
                                     created_at: "2012-03-27 14:53:59 UTC",
                                     updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(transaction).not_to be_valid
  end
  
  it 'is invalid without a credit card number' do
    transaction = Transaction.create(invoice_id: invoice.id,
                                     credit_card_expiration_date: nil,
                                     result: "success'",
                                     created_at: "2012-03-27 14:53:59 UTC",
                                     updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(transaction).not_to be_valid
  end
  
  it 'is invalid without a result' do
    transaction = Transaction.create(invoice_id: invoice.id,
                                     credit_card_number: "2424242424242424",
                                     credit_card_expiration_date: nil,
                                     created_at: "2012-03-27 14:53:59 UTC",
                                     updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(transaction).not_to be_valid
  end
  
  it 'is invalid without a created at date' do
    transaction = Transaction.create(invoice_id: invoice.id,
                                     credit_card_number: "2424242424242424",
                                     credit_card_expiration_date: nil,
                                     result: "success'",
                                     updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(transaction).not_to be_valid
  end
  
  it 'is invalid without an updated at date' do
    transaction = Transaction.create(invoice_id: invoice.id,
                                     credit_card_number: "2424242424242424",
                                     credit_card_expiration_date: nil,
                                     result: "success'",
                                     created_at: "2012-03-27 14:53:59 UTC")
    
    expect(transaction).not_to be_valid
  end
  
  it 'responds to invoice' do
    expect(transaction).to respond_to(:invoice)
  end
  
  it 'returns an actual invoice object' do
    expect(transaction.invoice).to eq(invoice)
  end
end
