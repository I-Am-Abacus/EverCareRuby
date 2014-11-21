require 'spec_helper'

describe "follows/show" do
  before(:each) do
    @follow = assign(:follow, stub_model(Follow,
      :cared_for_user_id => 1,
      :following_user_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain(1.to_s)
    rendered.should contain(2.to_s)
  end
end
