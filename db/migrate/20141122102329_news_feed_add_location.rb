class NewsFeedAddLocation < ActiveRecord::Migration
  def change
    add_column :news_items, :location, :string
  end
end
