class UserNulls < ActiveRecord::Migration
  def change
    change_column_null :users, :email, nulls: false
    change_column_null :users, :password_digest, nulls: false
    change_column_null :users, :admin, nulls: false
    change_column_null :users, :status, nulls: false
  end
end
