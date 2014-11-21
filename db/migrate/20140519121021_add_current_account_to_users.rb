class AddCurrentAccountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_account, :integer
  end
end
