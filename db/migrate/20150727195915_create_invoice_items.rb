class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.references :item, index: true, foreign_key: true
      t.references :invoice, index: true, foreign_key: true
      t.integer :quantity
      t.decimal :unit_price
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
