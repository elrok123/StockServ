class AddMemo < ActiveRecord::Migration
def change
    create_table :memos do |t|
      t.text :memo_description
      t.belongs_to :user, index:true
      t.timestamps null: false
    end
  end
end