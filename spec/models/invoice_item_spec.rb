require 'rails_helper'

describe 'InvoiceItem', :type => :model do

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
  
  it 'is valid' do
    expect(invoice_item).to be_valid
  end
  
  it 'is invalid without an item id' do
    invoice_item = InvoiceItem.create(invoice_id: invoice.id,
                                      quantity: 5,
                                      unit_price: 10,
                                      created_at: "2012-03-27 14:53:59 UTC",
                                      updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(invoice_item).not_to be_valid
  end
  
  it 'is invalid without an invoice id' do
    invoice_item = InvoiceItem.create(item_id: item.id,
                                      quantity: 5,
                                      unit_price: 10,
                                      created_at: "2012-03-27 14:53:59 UTC",
                                      updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(invoice_item).not_to be_valid
  end
  
  it 'is invalid without a quantity' do
    invoice_item = InvoiceItem.create(invoice_id: invoice.id,
                                      item_id: item.id,
                                      unit_price: 10,
                                      created_at: "2012-03-27 14:53:59 UTC",
                                      updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(invoice_item).not_to be_valid
  end
  
  it 'is invalid without a unit price' do
    invoice_item = InvoiceItem.create(invoice_id: invoice.id,
                                      item_id: item.id,
                                      quantity: 5,
                                      created_at: "2012-03-27 14:53:59 UTC",
                                      updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(invoice_item).not_to be_valid
  end
  
  it 'is invalid without a created at date' do
    invoice_item = InvoiceItem.create(invoice_id: invoice.id,
                                      item_id: item.id,
                                      unit_price: 10,
                                      quantity: 5,
                                      updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(invoice_item).not_to be_valid
  end
  
  it 'is invalid without an updated at date' do
    invoice_item = InvoiceItem.create(invoice_id: invoice.id,
                                      item_id: item.id,
                                      unit_price: 10,
                                      created_at: "2012-03-27 14:53:59 UTC",
                                      quantity: 5)
    
    expect(invoice_item).not_to be_valid
  end
  
  it 'responds to item' do
    expect(invoice_item).to respond_to(:item)
  end
  
  it 'returns the actual item object' do
    expect(invoice_item.item).to eq(item)
  end
  
  it 'responds to invoice' do
    expect(invoice_item).to respond_to(:invoice)
  end
  
  it 'returns the actual invoice object' do
    expect(invoice_item.invoice).to eq(invoice)
  end
end
