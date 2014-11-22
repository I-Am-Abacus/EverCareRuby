class AddUserFields < ActiveRecord::Migration
  def change
    add_column :users, :age, :integer
    add_column :users, :notes, :integer
    add_column :users, :contact_details, :integer
  end
end
