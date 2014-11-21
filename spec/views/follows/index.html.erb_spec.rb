require 'spec_helper'

describe "follows/index" do
  before(:each) do
    assign(:follows, [
      stub_model(Follow,
        :cared_for_user_id => 1,
        :following_user_id => 2
      ),
      stub_model(Follow,
        :cared_for_user_id => 1,
        :following_user_id => 2
      )
    ])
  end

  it "renders a list of follows" do
    render
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 2.to_s, :count => 2)
  end
end
