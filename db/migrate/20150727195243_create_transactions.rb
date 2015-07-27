class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :credit_card_number
      t.string :credit_card_expiration_date
      t.string :result
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
