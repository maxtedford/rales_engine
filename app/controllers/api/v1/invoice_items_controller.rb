class Api::V1::InvoiceItemsController < ApplicationController

  def index
    if params[:invoice_id]
      respond_with InvoiceItem.where(invoice_id: params[:invoice_id])
    elsif params[:item_id]
      respond_with InvoiceItem.where(item_id: params[:item_id])
    else
      respond_with InvoiceItem.all
    end
  end
  
  def random
    respond_with InvoiceItem.all.sample
  end

  def search
    respond_with InvoiceItem.find_by(params.first.first => params.first.last)
  end
  
  def find_all
    respond_with InvoiceItem.where(params.first.first => params.first.last)
  end
  
  def show
    respond_with InvoiceItem.find_by(id: params[:id])
  end
  
  def invoice
    respond_with InvoiceItem.find_by(id: params[:invoice_item_id]).invoice
  end
  
  def item
    respond_with InvoiceItem.find_by(id: params[:invoice_item_id]).item
  end
end
