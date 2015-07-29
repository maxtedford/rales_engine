require 'rails_helper'

describe Api::V1::CustomersController do
  
  let(:johnny) { Customer.create(first_name: "Johnny",
                                 last_name:  "Walker",
                                 created_at: "2012-03-27 14:58:07",
                                 updated_at: "2012-03-27 14:58:07") }
  let(:jorge)  { Customer.create(first_name: "Jorge",
                                 last_name:  "Bieber",
                                 created_at: "2012-03-27 14:58:07",
                                 updated_at: "2012-03-27 14:58:07") }
  
  before(:each) do
    johnny
    jorge
  end
  
  context '#index' do
    it 'returns all the customers' do
      get :index, format: :json
      
      expect(response).to have_http_status(:ok)
      
      customers = JSON.parse(response.body)
      
      expect(customers.count).to eq(2)
      expect(customers.first['first_name']).to eq("Johnny")
      expect(customers.last['first_name']).to eq("Jorge")
    end
  end
  
  context '#random' do  
    it 'returns a random sample customer' do
      get :random, format: :json
      
      expect(response).to have_http_status(:ok)
      
      customer = JSON.parse(response.body)
      
      expect(customer['first_name']).to eq("Johnny" || "Jorge")
    end
  end
  
  context '#search' do
    xit 'returns the customer thats been searched' do
      get :search, id: 1, format: :json
      
      expect(response).to have_http_status(:ok)
      
      customer = JSON.parse(response.body)
      
      expect(customer['first_name']).to eq("Johnny")
    end
  end
end
