class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :cared_for_user_id
      t.integer :following_user_id

      t.timestamps
    end
  end
end
