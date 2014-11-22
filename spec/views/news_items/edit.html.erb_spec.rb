require 'spec_helper'

describe "news_items/edit" do
  before(:each) do
    @news_item = assign(:news_item, stub_model(NewsItem,
      :user => nil,
      :carer_user => nil,
      :narrative => "MyString"
    ))
  end

  it "renders the edit news_item form" do
    render

    rendered.should have_selector("form", :action => news_item_path(@news_item), :method => "post") do |form|
      form.should have_selector("input#news_item_user", :name => "news_item[user]")
      form.should have_selector("input#news_item_carer_user", :name => "news_item[carer_user]")
      form.should have_selector("input#news_item_narrative", :name => "news_item[narrative]")
    end
  end
end
