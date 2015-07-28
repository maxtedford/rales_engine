require 'rails_helper'

describe 'Invoice', :type => :model do

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
    expect(invoice).to be_valid
  end
  
  it 'is invalid without customer id' do
    invoice = Invoice.create(merchant_id: merchant.id,
                             status: "shipped",
                             created_at: "2012-03-27 14:53:59 UTC",
                             updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(invoice).not_to be_valid
  end
  
  it 'is invalid without merchant id' do
    invoice = Invoice.create(customer_id: customer.id,
                             status: "shipped",
                             created_at: "2012-03-27 14:53:59 UTC",
                             updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(invoice).not_to be_valid
  end
  
  it 'is invalid without status' do
    invoice = Invoice.create(customer_id: customer.id,
                             merchant_id: merchant.id,
                             created_at: "2012-03-27 14:53:59 UTC",
                             updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(invoice).not_to be_valid
  end
  
  it 'is invalid without a created at date' do
    invoice = Invoice.create(customer_id: customer.id,
                             merchant_id: merchant.id,
                             status: "shipped",
                             updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(invoice).not_to be_valid
  end
  
  it 'is invalid without an updated at date' do
    invoice = Invoice.create(customer_id: customer.id,
                             merchant_id: merchant.id,
                             status: "shipped",
                             created_at: "2012-03-27 14:53:59 UTC")
    
    expect(invoice).not_to be_valid
  end
  
  it 'responds to customer' do
    expect(invoice).to respond_to(:customer)
  end
  
  it 'returns an actual customer object' do
    expect(invoice.customer).to eq(customer)
  end
  
  it 'responds to merchant' do
    expect(invoice).to respond_to(:merchant)
  end
  
  it 'returns an actual merchant object' do
    expect(invoice.merchant).to eq(merchant)
  end
  
  it 'responds to transactions' do
    expect(invoice).to respond_to(:transactions)
  end
  
  it 'returns actual transactions objects' do
    expect(invoice.transactions).to eq([transaction])
  end
  
  it 'responds to invoice_items' do
    expect(invoice).to respond_to(:invoice_items)
  end
  
  it 'returns actual invoice_item objects' do
    expect(invoice.invoice_items).to eq([invoice_item])
  end
  
  it 'responds to items' do
    expect(invoice).to respond_to(:items)
  end
  
  it 'returns actual item objects' do
    skip
    expect(invoice.items).to eq([item])
  end
end
