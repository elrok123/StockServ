class AddFundsToClients < ActiveRecord::Migration
  def change
  	change_table :clients do |t|
  		t.column :funds, :decimal, :precision => 8, :scale => 2, default: 0.00
  	end
  end
end
