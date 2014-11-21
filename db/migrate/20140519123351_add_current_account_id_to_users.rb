class AddCurrentAccountIdToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :current_account
    add_column :users, :current_account_id, :integer
  end
end
