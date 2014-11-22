class UserFixDataTypes < ActiveRecord::Migration
  def change
    change_column :users, :contact_details, :string
    change_column :users, :notes, :string
  end
end
