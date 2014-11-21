class CreateNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items do |t|
      t.references :user_id, index: true
      t.integer :carer_user_id, index: true, nulls: false
      t.string :narrative

      t.timestamps
    end
    add_index :news_items, [:id, :created_at], order: {created_at: :desc}
  end
end
