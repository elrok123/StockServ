class LinkUsersToMemos < ActiveRecord::Migration
  def change
  	change_table :memos do |t|
      t.text :description
      t.belongs_to :user, index: true
  	end
  end
end
