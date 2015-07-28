class Api::V1::MerchantsController < ApplicationController

  def random
    respond_with Merchant.all.sample
  end
  
  def search
    respond_with Merchant.find_by(params.first.first => params.first.last)
  end
  
  def find_all
    respond_with Merchant.where(params.first.first => params.first.last)
  end
  
  def show
    respond_with Merchant.find_by(id: params[:id])
  end
end
