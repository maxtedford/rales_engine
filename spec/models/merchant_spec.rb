require 'rails_helper'

describe 'Merchant', :type => :model do
  
  let(:valid_attrib) { { name: "Justin Bieber",
                         created_at: "2012-03-27 14:58:07 UTC",
                         updated_at: "2012-03-27 14:58:07 UTC" } }

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
    merchant
    
    expect(merchant).to be_valid
  end
  
  it 'is invalid without a name' do
    merchant = Merchant.create( created_at: "2012-03-27 14:58:07 UTC",
                                updated_at: "2012-03-27 14:58:07 UTC" )
    
    expect(merchant).not_to be_valid
  end
  
  it 'is invalid without a created at date' do
    merchant = Merchant.create( name: "Justin Bieber",
                                updated_at: "2012-03-27 14:58:07 UTC" )

    expect(merchant).not_to be_valid
  end
  
  it 'is invalid without an updated at date' do
    merchant = Merchant.create( name: "Justin Bieber",
                                created_at: "2012-03-27 14:58:07 UTC" )

    expect(merchant).not_to be_valid
  end
  
  it 'responds to items' do
    merchant = Merchant.create(valid_attrib)
    
    expect(merchant).to respond_to(:items)
  end
  
  it 'will return all the items associated with a particular merchant' do
    merchant
    item1    = Item.create( name: "Item 1",
                            description: "Item 1 description",
                            unit_price: 10,
                            merchant_id: merchant.id,
                            created_at: "2012-03-28 14:58:07 UTC",
                            updated_at: "2012-03-28 14:58:07 UTC" )
    item2    = Item.create( name: "Item 2",
                            description: "Item 2 description",
                            unit_price: 5,
                            merchant_id: merchant.id,
                            created_at: "2012-03-29 14:58:07 UTC",
                            updated_at: "2012-03-29 14:58:07 UTC")
    
    expect(merchant.items.count).to eq(2)
    expect(merchant.items.first.name).to eq("Item 1")
    expect(merchant.items.last.name).to eq("Item 2")
  end
  
  it 'responds to invoices' do
    merchant = Merchant.create(valid_attrib)
    
    expect(merchant).to respond_to(:invoices)
  end
  
  it 'will return all the invoices associated with a particular merchant' do
    merchant = Merchant.create(valid_attrib)
    customer = Customer.create(first_name: "Johnny",
                               last_name:  "Walker",
                               created_at: "2012-03-28 14:58:07 UTC",
                               updated_at: "2012-03-28 14:58:07 UTC")
    invoice1 = Invoice.create(customer_id: customer.id,
                              merchant_id: merchant.id,
                              status: "shipped",
                              created_at: "2012-03-29 14:58:07 UTC",
                              updated_at: "2012-03-29 14:58:07 UTC")
    invoice2 = Invoice.create(customer_id: customer.id,
                              merchant_id: merchant.id,
                              status: "paid",
                              created_at: "2012-03-30 14:58:07 UTC",
                              updated_at: "2012-03-30 14:58:07 UTC")
    
    expect(merchant.invoices.count).to eq(2)
    expect(merchant.invoices.first.status).to eq("shipped")
    expect(merchant.invoices.last.status).to eq("paid")
  end
  
  it 'responds to customers' do
    merchant = Merchant.create(valid_attrib)
    
    expect(merchant).to respond_to(:customers)
  end
  
  it 'will return all the customers associated with a particular merchant' do
    merchant = Merchant.create(valid_attrib)
    johnny   = Customer.create(first_name: "Johnny",
                               last_name:  "Walker",
                               created_at: "2012-03-28 14:58:07 UTC",
                               updated_at: "2012-03-28 14:58:07 UTC")
    jim      = Customer.create(first_name: "Jim",
                               last_name:  "Beam",
                               created_at: "2012-03-28 16:58:07 UTC",
                               updated_at: "2012-03-28 16:58:07 UTC")
    invoice1 = Invoice.create(customer_id: johnny.id,
                              merchant_id: merchant.id,
                              status: "shipped",
                              created_at: "2012-03-29 14:58:07 UTC",
                              updated_at: "2012-03-29 14:58:07 UTC")
    invoice2 = Invoice.create(customer_id: jim.id,
                              merchant_id: merchant.id,
                              status: "paid",
                              created_at: "2012-03-30 14:58:07 UTC",
                              updated_at: "2012-03-30 14:58:07 UTC")
    
    expect(merchant.customers.count).to eq(2)
    expect(merchant.customers.first).to eq(johnny)
    expect(merchant.customers.last).to eq(jim)
  end
  
  it 'can return the revenue for a single merchant' do
    merchant; customer; item; invoice; invoice_item; transaction
    
    expect(merchant.total_revenue.class).to eq(BigDecimal)
  end
  
  it 'can return the most items for a single merchant' do
    merchant; customer; item; invoice; invoice_item; transaction
    
    expect(merchant.total_items.class).to eq(Fixnum)
  end
  
  it 'can return a merchants revenue by date' do
    merchant; customer; item; invoice; invoice_item; transaction
    
    expect(merchant.revenue_by_date("2012-03-29 14:58:07 UTC").class).to eq(BigDecimal)
  end
end
