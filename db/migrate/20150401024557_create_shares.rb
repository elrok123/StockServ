class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.string :company_tag

      t.timestamps null: false
    end
  end
end
