class SessionNulls < ActiveRecord::Migration
  def change
    change_column_null :sessions, :user_id, nulls: false
    change_column_null :sessions, :remember_token, nulls: false
  end
end
