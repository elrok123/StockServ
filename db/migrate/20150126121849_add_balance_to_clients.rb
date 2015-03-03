class AddBalanceToClients < ActiveRecord::Migration
  	def change
    		add_column :clients, :balance, :float
  	end
end
