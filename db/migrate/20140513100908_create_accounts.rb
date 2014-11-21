class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user, index: true, dependant: :delete
      t.string :name
      t.boolean :public
      t.integer :status, limit: 2

      t.timestamps
    end
    # add_foreign_key(:accounts, :user, name: 'fk_accounts_users')
  end
end
