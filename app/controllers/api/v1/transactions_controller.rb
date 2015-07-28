class Api::V1::TransactionsController < ApplicationController

  def index
    respond_with Transaction.where(invoice_id: params[:invoice_id])
  end
  
  def random
    respond_with Transaction.all.sample
  end

  def search
    respond_with Transaction.find_by(params.first.first => params.first.last)
  end
  
  def find_all
    respond_with Transaction.where(params.first.first => params.first.last)
  end
  
  def show
    respond_with Transaction.find_by(id: params[:id])
  end
  
  def invoice
    respond_with Transaction.find_by(id: params[:transaction_id]).invoice
  end
end
