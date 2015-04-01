class CreateOwnedShares < ActiveRecord::Migration
  def change
    create_table :owned_shares do |t|
      t.belongs_to :share, index: true
      t.belongs_to :client, index: true
      t.string :company_tag
      t.column :close_price, :decimal, :precision => 8, :scale => 2, default: 0.00
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
