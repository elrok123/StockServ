class RemoveCompanyTagFromOwnedShares < ActiveRecord::Migration
  def change
  	remove_column :owned_shares, :company_tag
  end
end
