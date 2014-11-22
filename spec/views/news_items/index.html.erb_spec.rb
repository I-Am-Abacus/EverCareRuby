require 'spec_helper'

describe "news_items/index" do
  before(:each) do
    assign(:news_items, [
      stub_model(NewsItem,
        :user => nil,
        :carer_user => nil,
        :narrative => "Narrative"
      ),
      stub_model(NewsItem,
        :user => nil,
        :carer_user => nil,
        :narrative => "Narrative"
      )
    ])
  end

  it "renders a list of news_items" do
    render
    rendered.should have_selector("tr>td", :content => nil.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => nil.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Narrative".to_s, :count => 2)
  end
end
