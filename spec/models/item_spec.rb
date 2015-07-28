require 'rails_helper'

describe 'Item', :type => :model do
  
  let(:merchant)     { Merchant.create(name: "Justin Bieber",
                                       created_at: "2012-03-27 14:53:59 UTC",
                                       updated_at: "2012-03-27 14:53:59 UTC") }
  let(:valid_attrib) { { name: "Item",
                         description: "Item description",
                         unit_price: 10,
                         merchant_id: merchant.id,
                         created_at: "2012-03-27 14:53:59 UTC",
                         updated_at: "2012-03-27 14:53:59 UTC" } }
  
  it 'is valid' do
    item = Item.create(valid_attrib)
    
    expect(item).to be_valid
  end
  
  it 'is invalid without a name' do
    item = Item.create(description: "Item description",
                       unit_price: 10,
                       merchant_id: merchant.id,
                       created_at: "2012-03-27 14:53:59 UTC",
                       updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(item).not_to be_valid
  end
  
  it 'is invalid without a description' do
    item = Item.create(name: "Item",
                       unit_price: 10,
                       merchant_id: merchant.id,
                       created_at: "2012-03-27 14:53:59 UTC",
                       updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(item).not_to be_valid
  end
  
  it 'is invalid without a unit price' do
    item = Item.create(name: "Item",
                       description: "Item description",
                       merchant_id: merchant.id,
                       created_at: "2012-03-27 14:53:59 UTC",
                       updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(item).not_to be_valid
  end
  
  it 'is invalid without a merchant id' do
    item = Item.create(name: "Item",
                       description: "Item description",
                       unit_price: 10,  
                       created_at: "2012-03-27 14:53:59 UTC",
                       updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(item).not_to be_valid
  end
  
  it 'is invalid without a created at date' do
    item = Item.create(name: "Item",
                       description: "Item description",
                       unit_price: 10,
                       merchant_id: merchant.id,
                       updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(item).not_to be_valid
  end
  
  it 'is invalid without an updated at date' do
    item = Item.create(name: "Item",
                       description: "Item description",
                       unit_price: 10,
                       merchant_id: merchant.id,
                       created_at: "2012-03-27 14:53:59 UTC")
    
    expect(item).not_to be_valid
  end
  
  it 'responds to merchant' do
    item = Item.create(valid_attrib)
    
    expect(item).to respond_to(:merchant)
  end
  
  it 'can return the merchant to which it belongs' do
    item = Item.create(valid_attrib)
    
    expect(item.merchant).to eq(merchant)
  end
  
  it 'responds to invoice items' do
    item = Item.create(valid_attrib)
    
    expect(item).to respond_to(:invoice_items)
  end
  
  it 'can return all of its invoice items' do
    item = Item.create(valid_attrib)
    customer = Customer.create(first_name: "Johnny",
                               last_name: "Walker",
                               created_at: "2012-03-27 14:53:59 UTC",
                               updated_at: "2012-03-27 14:53:59 UTC")
    invoice = Invoice.create(customer_id: customer.id,
                             merchant_id: merchant.id,
                             status: "shipped",
                             created_at: "2012-03-27 14:53:59 UTC",
                             updated_at: "2012-03-27 14:53:59 UTC")
    invoice_item1 = InvoiceItem.create(item_id: item.id,
                                       invoice_id: invoice.id,
                                       quantity: 5,
                                       unit_price: 10,
                                       created_at: "2012-03-27 14:53:59 UTC",
                                       updated_at: "2012-03-27 14:53:59 UTC")
    invoice_item2 = InvoiceItem.create(item_id: item.id,
                                       invoice_id: invoice.id,
                                       quantity: 3,
                                       unit_price: 10,
                                       created_at: "2012-03-27 14:53:59 UTC",
                                       updated_at: "2012-03-27 14:53:59 UTC")
    
    expect(item.invoice_items.count).to eq(2)
    expect(item.invoice_items.first).to eq(invoice_item1)
    expect(item.invoice_items.last).to eq(invoice_item2)
  end
  
  it 'responds to invoices' do
    item = Item.create(valid_attrib)
    
    expect(item).to respond_to(:invoices)
  end
  
  it 'can return all of its invoices' do
    item = Item.create(valid_attrib)
    customer = Customer.create(first_name: "Johnny",
                               last_name: "Walker",
                               created_at: "2012-03-27 14:53:59 UTC",
                               updated_at: "2012-03-27 14:53:59 UTC")
    invoice1 = Invoice.create(customer_id: customer.id,
                              merchant_id: merchant.id,
                              status: "shipped",
                              created_at: "2012-03-27 14:53:59 UTC",
                              updated_at: "2012-03-27 14:53:59 UTC")
    invoice2 = Invoice.create(customer_id: customer.id,
                              merchant_id: merchant.id,
                              status: "paid",
                              created_at: "2012-03-27 14:53:59 UTC",
                              updated_at: "2012-03-27 14:53:59 UTC")
    invoice_item1 = InvoiceItem.create(item_id: item.id,
                                       invoice_id: invoice1.id,
                                       quantity: 5,
                                       unit_price: 10,
                                       created_at: "2012-03-27 14:53:59 UTC",
                                       updated_at: "2012-03-27 14:53:59 UTC")
    invoice_item2 = InvoiceItem.create(item_id: item.id,
                                       invoice_id: invoice2.id,
                                       quantity: 5,
                                       unit_price: 10,
                                       created_at: "2012-03-27 14:53:59 UTC",
                                       updated_at: "2012-03-27 14:53:59 UTC")

    expect(item.invoices.count).to eq(2)
    expect(item.invoices.first).to eq(invoice1)
    expect(item.invoices.last).to eq(invoice2)
  end
end
