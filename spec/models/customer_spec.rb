require 'rails_helper'

describe 'Customer', :type => :model do
  
  let(:valid_attrib) { { first_name: "Johnny", 
                         last_name:  "Walker",
                         created_at: "2012-03-27 14:58:07 UTC",
                         updated_at: "2012-03-27 14:58:07 UTC" } }
  
  it 'is valid' do
    customer = Customer.create(valid_attrib)
    
    expect(customer).to be_valid
  end
  
  it 'is invalid without a first name' do
    customer = Customer.create( last_name: "Walker", 
                                created_at: "2012-03-27 14:58:07 UTC",
                                updated_at: "2012-03-27 14:58:07 UTC" )
    
    expect(customer).not_to be_valid
  end
  
  it 'is invalid without a last name' do
    customer = Customer.create( first_name: "Johnny",
                                created_at: "2012-03-27 14:58:07 UTC",
                                updated_at: "2012-03-27 14:58:07 UTC" )
    
    expect(customer).not_to be_valid
  end
  
  it 'is invalid without a created at date' do
    customer = Customer.create( first_name: "Johnny",
                                last_name: "Walker",
                                updated_at: "2012-03-27 14:58:07 UTC" )

    expect(customer).not_to be_valid
  end
  
  it 'is invalid without an updated at date' do
    customer = Customer.create( first_name: "Johnny",
                                last_name: "Walker",
                                created_at: "2012-03-27 14:58:07 UTC" )

    expect(customer).not_to be_valid
  end
  
  it 'can return the invoices for a particular customer' do
    customer = Customer.create(valid_attrib)
    merchant = Merchant.create(name: "Justin Bieber",
                               created_at: "2012-03-28 14:58:07 UTC",
                               updated_at: "2012-03-28 14:58:07 UTC")
    invoice1 = Invoice.create( customer_id: customer.id,
                               merchant_id: merchant.id,
                               status: "shipped",
                               created_at: "2012-03-28 14:58:07 UTC",
                               updated_at: "2012-03-28 14:58:07 UTC" )
    invoice2 = Invoice.create( customer_id: customer.id,
                               merchant_id: merchant.id,
                               status: "shipped",
                               created_at: "2012-03-29 14:58:07 UTC",
                               updated_at: "2012-03-29 14:58:07 UTC" )
    
    expect(customer).to respond_to(:invoices)
    expect(customer.invoices.count).to eq(2)
  end
  
  it 'can return the merchants for a particular customer' do
    skip
    customer = Customer.create(valid_attrib)
    merchant = Merchant.create(name: "Justin Bieber",
                               created_at: "2012-03-28 14:58:07 UTC",
                               updated_at: "2012-03-28 14:58:07 UTC")
    invoice1 = Invoice.create( customer_id: customer.id,
                               merchant_id: merchant.id,
                               status: "shipped",
                               created_at: "2012-03-28 14:58:07 UTC",
                               updated_at: "2012-03-28 14:58:07 UTC" )
    
    expect(customer).to respond_to(:merchants)
    expect(customer.merchants.count).to eq(1)

    invoice2 = Invoice.create( customer_id: customer.id,
                               merchant_id: merchant.id,
                               status: "shipped",
                               created_at: "2012-03-29 14:58:07 UTC",
                               updated_at: "2012-03-29 14:58:07 UTC" )
    
    expect(customer.merchants.count).to eq(1)
  end
end
