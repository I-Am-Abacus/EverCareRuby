require 'spec_helper'

describe "news_items/show" do
  before(:each) do
    @news_item = assign(:news_item, stub_model(NewsItem,
      :user => nil,
      :carer_user => nil,
      :narrative => "Narrative"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain(nil.to_s)
    rendered.should contain(nil.to_s)
    rendered.should contain("Narrative".to_s)
  end
end
