class LinkUsersToClients < ActiveRecord::Migration
  def change
    change_table :clients do |t|
      t.belongs_to :user, index:true
      t.string :title
    end
  end
end
