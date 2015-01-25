class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.has_many :clients
      t.string :username
      t.string :email
      t.string :password_salt
      t.string :password_hash

      t.timestamps null: false
    end
  end
end
