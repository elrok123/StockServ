class CreateWatchlists < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.string :stock_symbol
      t.timestamps null: false
    end
 
    create_table :watchlists do |t|
      t.belongs_to :user, index: true
      t.belongs_to :favourite, index: true
      t.timestamps null: false
    end
  end
end