class UserAddCareNotes < ActiveRecord::Migration
  def change
    add_column :users, :care_notes_collection, :string
  end
end
