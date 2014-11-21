class AddNameStatusToUser < ActiveRecord::Migration
  def down
    remove_column(:users, :status)
    remove_column(:users, :user_status)
  end
  def up
    add_column(:users, :status, :integer, limit: 2)
  end
end
