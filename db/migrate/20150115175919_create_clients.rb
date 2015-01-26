class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :address
      t.string :home_tel
      t.string :mobile_tel
      t.string :email

      t.timestamps null: false
    end
  end
end
