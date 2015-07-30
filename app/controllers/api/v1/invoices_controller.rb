class Api::V1::InvoicesController < ApplicationController

  def index
    if params[:merchant_id]
      respond_with Invoice.where(merchant_id: params[:merchant_id])
    elsif params[:customer_id]
      respond_with Invoice.where(customer_id: params[:customer_id])
    else
      respond_with Invoice.all
    end
  end
  
  def random
    respond_with Invoice.all.sample
  end

  def search
    respond_with Invoice.find_by(params.first.first => params.first.last)
  end
  
  def find_all
    respond_with Invoice.where(params.first.first => params.first.last)
  end
  
  def show
    respond_with Invoice.find_by(id: params[:id])
  end
  
  def customer
    respond_with Invoice.find_by(id: params[:invoice_id]).customer
  end
  
  def merchant
    respond_with Invoice.find_by(id: params[:invoice_id]).merchant
  end
end
