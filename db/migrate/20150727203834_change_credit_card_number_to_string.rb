class ChangeCreditCardNumberToString < ActiveRecord::Migration
  def change
    change_table :transactions do |t|
      t.change :credit_card_number, :string
    end
  end
end
