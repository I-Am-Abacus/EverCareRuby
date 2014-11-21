class AccountNulls < ActiveRecord::Migration
  def change
    change_column_null :accounts, :user_id, nulls: false
    change_column_null :accounts, :public, nulls: false
    change_column_null :accounts, :status, nulls: false
  end
end
