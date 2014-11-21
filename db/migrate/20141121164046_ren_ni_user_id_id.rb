class RenNiUserIdId < ActiveRecord::Migration
  def change
    rename_column :news_items, :user_id_id, :user_id
  end
end
