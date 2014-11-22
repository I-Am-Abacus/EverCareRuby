require 'spec_helper'

describe "news_items/new" do
  before(:each) do
    assign(:news_item, stub_model(NewsItem,
      :user => nil,
      :carer_user => nil,
      :narrative => "MyString"
    ).as_new_record)
  end

  it "renders new news_item form" do
    render

    rendered.should have_selector("form", :action => news_items_path, :method => "post") do |form|
      form.should have_selector("input#news_item_user", :name => "news_item[user]")
      form.should have_selector("input#news_item_carer_user", :name => "news_item[carer_user]")
      form.should have_selector("input#news_item_narrative", :name => "news_item[narrative]")
    end
  end
end
