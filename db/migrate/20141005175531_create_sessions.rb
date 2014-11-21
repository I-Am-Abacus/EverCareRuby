class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :user, index: true
      t.string :remember_token

      t.timestamps
    end
    add_index :sessions, :remember_token
  end
end
